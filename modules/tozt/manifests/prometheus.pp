class tozt::prometheus {
  include postgres;
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

  file { "/etc/grafana.ini":
    source => "puppet:///modules/tozt/grafana.ini",
    require => Package["grafana"];
  }

  exec { "create grafana db user":
    provider => shell,
    command => "createuser -d grafana",
    user => 'postgres',
    unless => "psql -Atc 'select usename from pg_catalog.pg_user' | grep -F grafana",
    require => [
      Package["postgresql"],
      Service["postgresql"],
    ];
  }

  exec { "create grafana db":
    provider => shell,
    command => "createdb -U grafana grafana",
    user => 'postgres',
    unless => "psql -Atc 'select datname from pg_catalog.pg_database' | grep -F grafana",
    require => [
      Exec["create grafana db user"],
      Package["postgresql"],
      Service["postgresql"],
    ];
  }

  nginx::site {
    "prometheus-tls":
      source => 'puppet:///modules/tozt/nginx/prometheus-tls.conf',
      require => Class['certbot'];
    "prometheus":
      source => 'puppet:///modules/tozt/nginx/prometheus.conf';
    "grafana-tls":
      source => 'puppet:///modules/tozt/nginx/grafana-tls.conf',
      require => Class['certbot'];
    "grafana":
      source => 'puppet:///modules/tozt/nginx/grafana.conf';
  }
}
