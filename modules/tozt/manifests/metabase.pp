class tozt::metabase {
  include tozt::certbot
  include tozt::persistent
  include metabase

  nginx::site {
    "metabase-tls":
      source => 'puppet:///modules/tozt/nginx/metabase-tls.conf',
      require => Class['certbot'];
    "metabase":
      source => 'puppet:///modules/tozt/nginx/metabase.conf';
  }

  exec { "create money db":
    provider => shell,
    command => "createdb -U metabase money",
    user => 'postgres',
    unless => "psql -Atc 'select datname from pg_catalog.pg_database' | grep -F money",
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
    "/home/doy/.config/google":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => Conf::User["doy"];
  }

  cron::job { "metabase":
    frequency => "hourly",
    source => "puppet:///modules/tozt/metabase",
    require => [
      Package::Cargo["ynab-export for doy"],
      Exec["clone metabase-utils"],
      Secret["/home/doy/.config/ynab/api-key"],
      Secret["/home/doy/.config/google/investments-sheet"],
      Exec["create money db"],
    ];
  }

  secret { "/home/doy/.config/ynab/api-key":
    source => "ynab",
    owner => 'doy',
    group => 'doy',
    require => File["/home/doy/.config/ynab"];
  }

  secret { "/home/doy/.config/google/investments-sheet":
    source => "investments-sheet",
    owner => 'doy',
    group => 'doy',
    require => File["/home/doy/.config/google"];
  }

  package::cargo { "ynab-export for doy":
    ensure => installed,
    user => 'doy',
    package => 'ynab-export';
  }

  exec { "clone metabase-utils":
    command => "/usr/bin/git clone git://github.com/doy/metabase-utils",
    user => "doy",
    cwd => "/home/doy/coding",
    creates => "/home/doy/coding/metabase-utils",
    require => [
      Class["git"],
      File["/home/doy/coding"],
    ],
  }
}
