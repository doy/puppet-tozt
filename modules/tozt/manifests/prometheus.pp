class tozt::prometheus {
  include prometheus

  file {
    "/media/persistent/prometheus":
      ensure => directory,
      owner => "prometheus",
      group => "prometheus",
      require => [
        File["/media/persistent"],
        Package["prometheus"],
      ];
    "/etc/conf.d/prometheus":
      source => "puppet:///modules/tozt/prometheus-service-conf",
      require => Package["prometheus"],
      notify => Service["prometheus"];
  }

  nginx::site {
    "prometheus-tls":
      source => 'puppet:///modules/tozt/nginx/prometheus-tls.conf',
      require => Class['certbot'];
    "prometheus":
      source => 'puppet:///modules/tozt/nginx/prometheus.conf';
  }
}
