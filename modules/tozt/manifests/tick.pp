class tozt::tick {
  include tick::server

  nginx::site {
    "influxdb-tls":
      source => 'puppet:///modules/tozt/nginx/influxdb-tls.conf',
      require => Class['certbot'];
    "influxdb":
      source => 'puppet:///modules/tozt/nginx/influxdb.conf';
  }
}
