class tozt::prometheus {
  include prometheus
  include grafana

  file { "/media/persistent/prometheus":
    ensure => directory,
    owner => "prometheus",
    group => "prometheus",
    require => [
      File["/media/persistent"],
      Package["prometheus"],
    ];
  }

  systemd::override { "prometheus":
    source => 'puppet:///modules/tozt/prometheus-override.conf';
  }

  $smtp_password = secret::value("grafana_smtp_password")

  file { "/etc/grafana.ini":
    content => template("tozt/grafana.ini"),
    require => Package["grafana"];
  }

  exec { "install grafana sqlite plugin":
    provider => shell,
    command => "grafana cli plugins install frser-sqlite-datasource",
    creates => "/var/lib/grafana/plugins/frser-sqlite-datasource",
    require => Package["grafana"],
  }

  nginx::site {
    "grafana-tls":
      source => 'puppet:///modules/tozt/nginx/grafana-tls.conf',
      require => Class['certbot'];
    "grafana":
      source => 'puppet:///modules/tozt/nginx/grafana.conf';
  }

  secret { "/media/persistent/grafana.htpasswd":
    source => "grafana",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
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
    command => "/usr/bin/git clone https://github.com/doy/metabase-utils",
    user => "doy",
    cwd => "/home/doy/coding",
    creates => "/home/doy/coding/metabase-utils",
    require => [
      Class["git"],
      File["/home/doy/coding"],
    ],
  }

  cron::job { "refresh-metabase":
    frequency => "hourly",
    source => "puppet:///modules/tozt/metabase",
    require => [
      Package::Cargo["ynab-export for doy"],
      Exec["clone metabase-utils"],
      Secret["/home/doy/.config/ynab/api-key"],
      Secret["/home/doy/.config/google/investments-sheet"],
    ];
  }
}
