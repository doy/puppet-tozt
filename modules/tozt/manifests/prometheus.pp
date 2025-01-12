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
}
