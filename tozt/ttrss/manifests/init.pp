class ttrss($dbpath) {
  include systemd

  package {
    [
      "tt-rss",
      "postgres",
      "php-pgsql",
    ]:
      ensure => installed;
  }

  file {
    $dbpath:
      owner => 'postgres',
      group => 'postgres',
      require => Package["postgres"];
    "$dbpath/data":
      owner => 'postgres',
      group => 'postgres',
      require => [
        Package["postgres"],
        File[$dbpath],
      ];
    "/etc/systemd/system/postgresql.service.d":
      ensure => directory;
    "/etc/systemd/system/postgresql.service.d/override.conf":
      content => template('ttrss/postgres-service'),
      notify => Exec["systemctl daemon-reload"],
      require => File["/etc/systemd/system/postgresql.service.d"];
    "/etc/webapps/tt-rss/config.php":
      source => "puppet:///modules/ttrss/config.php",
      require => Package["tt-rss"];
    "/etc/pacman.d/hooks":
      ensure => directory;
    "/etc/pacman.d/hooks/tt-rss.hook":
      source => "puppet:///modules/ttrss/pacman-hook",
      require => [
        File["/etc/pacman.d/hooks"],
        Package["tt-rss"],
      ]
  }

  exec { "initialize db path":
    command => "/usr/bin/initdb -D $dbpath/data",
    user => 'postgres',
    creates => "$dbpath/data/PG_VERSION",
    require => Package["postgres"];
  }

  service { "postgres":
    ensure => running,
    require => Exec["initialize db path"];
  }

  exec { "create db user":
    provider => shell,
    command => "createuser -d ttrss",
    user => 'postgres',
    unless => "psql -Atc 'select usename from pg_catalog.pg_user' | grep -F ttrss",
    require => [
      Package["postgres"],
      Service["postgres"],
    ];
  }

  exec { "create db":
    provider => shell,
    command => "createdb -U ttrss ttrss",
    user => 'postgres',
    unless => "psql -Atc 'select datname from pg_catalog.pg_database' | grep -F ttrss",
    require => [
      Exec["create db user"],
      Package["postgres"],
      Service["postgres"],
    ];
  }

  exec { "fixup php.ini":
    provider => shell,
    command => "sed -i 's/^;\\(extension=.*pgsql\\)$/\\1/' /etc/php/php.ini",
    unless => "grep -q '^extension=pgsql$' /etc/php/php.ini && grep -q '^extension=pdo_pgsql$' /etc/php/php.ini",
    require => Package["php-pgsql"];
  }

  exec { "initialize tt-rss db":
    provider => shell,
    command => "psql ttrss -U ttrss -f /usr/share/webapps/tt-rss/schema/ttrss_schema_pgsql.sql",
    user => 'postgres',
    unless => "psql -d ttrss -Atc 'select relname from pg_catalog.pg_class;' | grep -q '^ttrss'",
    require => [
      Package["postgres"],
      Service["postgres"],
      Exec["create db"],
      Package["tt-rss"],
      File["/etc/webapps/tt-rss/config.php"],
    ]
  }

  service { "tt-rss":
    ensure => running,
    require => [
      Package["tt-rss"],
      Exec["fixup php.ini"],
      File["/etc/webapps/tt-rss/config.php"],
      Exec["create db"],
    ]
  }
}
