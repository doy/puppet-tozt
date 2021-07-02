class tozt::prometheus {
  include prometheus

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

  nginx::site {
    "prometheus-tls":
      source => 'puppet:///modules/tozt/nginx/prometheus-tls.conf',
      require => Class['certbot'];
    "prometheus":
      source => 'puppet:///modules/tozt/nginx/prometheus.conf';
  }
}
