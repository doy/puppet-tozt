class tozt::prometheus {
  include prometheus

  nginx::site {
    "prometheus-tls":
      source => 'puppet:///modules/tozt/nginx/prometheus-tls.conf',
      require => Class['certbot'];
    "prometheus":
      source => 'puppet:///modules/tozt/nginx/prometheus.conf';
  }
}
