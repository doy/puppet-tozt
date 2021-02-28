class tozt::tick {
  include tick::server

  tick::server::kapacitor::alert {
    "deadman":
      source => 'puppet:///modules/tozt/kapacitor/deadman.tick';
    "cpu":
      source => 'puppet:///modules/tozt/kapacitor/cpu.tick';
    # TODO: disk and network usage are a bit more all over the place (and it's
    # not super clear that these alerts are even correct), need to figure out a
    # better way to express these alerts
    # "net":
    #   source => 'puppet:///modules/tozt/kapacitor/net.tick';
    # "disk":
    #   source => 'puppet:///modules/tozt/kapacitor/disk.tick';
    "certbot":
      source => 'puppet:///modules/tozt/kapacitor/certbot.tick';
    "tarsnap":
      source => 'puppet:///modules/tozt/kapacitor/tarsnap.tick';
    "duplicati":
      source => 'puppet:///modules/tozt/kapacitor/duplicati.tick';
    "partofme-data":
      source => 'puppet:///modules/tozt/kapacitor/partofme-data.tick';
  }

  nginx::site {
    "influxdb-tls":
      source => 'puppet:///modules/tozt/nginx/influxdb-tls.conf',
      require => Class['certbot'];
    "influxdb":
      source => 'puppet:///modules/tozt/nginx/influxdb.conf';
  }
}
