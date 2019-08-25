class tozt::metabase {
  include tozt::certbot
  include tozt::persistent
  include metabase

  secret { "/media/persistent/metabase.htpasswd":
    source => "metabase",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }

  nginx::site {
    "metabase-tls":
      source => 'puppet:///modules/tozt/nginx/metabase-tls.conf',
      require => Class['certbot'];
    "metabase":
      source => 'puppet:///modules/tozt/nginx/metabase.conf';
  }

  exec { "create ynab db":
    provider => shell,
    command => "createdb -U metabase ynab",
    user => 'postgres',
    unless => "psql -Atc 'select datname from pg_catalog.pg_database' | grep -F ynab",
    require => [
      Exec["create metabase db user"],
      Package["postgresql"],
      Service["postgresql"],
    ];
  }

  exec { "create investments db":
    provider => shell,
    command => "createdb -U metabase investments",
    user => 'postgres',
    unless => "psql -Atc 'select datname from pg_catalog.pg_database' | grep -F investments",
    require => [
      Exec["create metabase db user"],
      Package["postgresql"],
      Service["postgresql"],
    ];
  }

  file {
    "/home/doy/.config/ynab":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => Conf::User["doy"];
    "/etc/cron.hourly/metabase":
      mode => '0755',
      source => "puppet:///modules/tozt/metabase",
      require => [
        Exec["clone ynab-export"],
        Exec["clone investments-sheet-export"],
        Secret["/home/doy/.config/ynab/api-key"],
        Secret["/home/doy/.config/google/investment-sheets"],
        Exec["create ynab db"],
        Exec["create investments db"],
      ];
  }

  secret { "/home/doy/.config/ynab/api-key":
    source => "ynab",
    owner => 'doy',
    group => 'doy',
    require => File["/home/doy/.config/ynab"];
  }

  secret { "/home/doy/.config/google/investment-sheets":
    source => "investments-sheets",
    owner => 'doy',
    group => 'doy',
    require => File["/home/doy/.config/google"];
  }

  exec { "clone ynab-export":
    command => "/usr/bin/git clone git://github.com/doy/ynab-export",
    user => "doy",
    cwd => "/home/doy/coding",
    creates => "/home/doy/coding/ynab-export",
    require => [
      Class["git"],
      File["/home/doy/coding"],
    ],
  }

  exec { "clone investments-sheet-export":
    command => "/usr/bin/git clone git://github.com/doy/investments-sheet-export",
    user => "doy",
    cwd => "/home/doy/coding",
    creates => "/home/doy/coding/investments-sheet-export",
    require => [
      Class["git"],
      File["/home/doy/coding"],
    ],
  }
}
