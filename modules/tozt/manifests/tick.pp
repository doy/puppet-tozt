class tozt::tick {
  include tick::server

  tick::server::kapacitor::alert {
    "deadman":
      source => 'puppet:///modules/tozt/kapacitor/deadman.tick';
    "cpu":
      source => 'puppet:///modules/tozt/kapacitor/cpu.tick';
  }

  secret {
    "/media/persistent/influxdb.htpasswd":
      source => 'influxdb_htpasswd',
      owner => 'http';
    "/media/persistent/chronograf.htpasswd":
      source => 'chronograf_htpasswd',
      owner => 'http';
  }

  nginx::site {
    "influxdb-tls":
      source => 'puppet:///modules/tozt/nginx/influxdb-tls.conf',
      require => Class['certbot'];
    "influxdb":
      source => 'puppet:///modules/tozt/nginx/influxdb.conf';
    "chronograf-tls":
      source => 'puppet:///modules/tozt/nginx/chronograf-tls.conf',
      require => Class['certbot'];
    "chronograf":
      source => 'puppet:///modules/tozt/nginx/chronograf.conf';
  }
}