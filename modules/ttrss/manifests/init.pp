class ttrss {
  include postgres;

  package {
    [
      "tt-rss",
      "php7-pgsql",
      "php-fpm",
    ]:
      ensure => installed;
  }

  file {
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
      ];
  }

  exec { "create ttrss db user":
    provider => shell,
    command => "createuser -d ttrss",
    user => 'postgres',
    unless => "psql -Atc 'select usename from pg_catalog.pg_user' | grep -F ttrss",
    require => [
      Package["postgresql"],
      Service["postgresql"],
    ];
  }

  exec { "create ttrss db":
    provider => shell,
    command => "createdb -U ttrss ttrss",
    user => 'postgres',
    unless => "psql -Atc 'select datname from pg_catalog.pg_database' | grep -F ttrss",
    require => [
      Exec["create ttrss db user"],
      Package["postgresql"],
      Service["postgresql"],
    ];
  }

  exec { "fixup php.ini for pgsql":
    provider => shell,
    command => "sed -i 's/^;\\(extension=.*pgsql\\)$/\\1/' /etc/php7/php.ini",
    unless => "grep -q '^extension=pgsql$' /etc/php7/php.ini && grep -q '^extension=pdo_pgsql$' /etc/php7/php.ini",
    require => Package["php7-pgsql"];
  }

  exec { "fixup php.ini for intl":
    provider => shell,
    command => "sed -i 's/^;\\(extension=intl\\)$/\\1/' /etc/php7/php.ini",
    unless => "grep -q '^extension=intl$' /etc/php7/php.ini",
    require => Package["tt-rss"];
  }

  exec { "initialize tt-rss db":
    provider => shell,
    command => "psql ttrss -U ttrss -f /usr/share/webapps/tt-rss/schema/ttrss_schema_pgsql.sql",
    user => 'postgres',
    unless => "psql -d ttrss -Atc 'select relname from pg_catalog.pg_class;' | grep -q '^ttrss'",
    require => [
      Package["postgresql"],
      Service["postgresql"],
      Exec["create ttrss db"],
      Package["tt-rss"],
      File["/etc/webapps/tt-rss/config.php"],
    ]
  }

  service { "tt-rss":
    ensure => running,
    enable => true,
    require => [
      Package["tt-rss"],
      Exec["fixup php.ini for pgsql"],
      Exec["fixup php.ini for intl"],
      File["/etc/webapps/tt-rss/config.php"],
      Exec["create ttrss db"],
    ]
  }

  service { "php-fpm":
    ensure => running,
    enable => true,
    require => Package["php-fpm"];
  }
}
