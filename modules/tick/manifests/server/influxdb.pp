class tick::server::influxdb {
  package { 'influxdb':
    ensure => installed;
  }

  file {
    "/etc/influxdb":
      ensure => directory;
    "/etc/influxdb/influxdb.conf":
      source => "puppet:///modules/tick/influxdb.conf",
      require => [
        Package['influxdb'],
        File["/etc/influxdb"],
      ],
      notify => Service['influxdb'];
    "/media/persistent/influxdb":
      ensure => directory,
      require => Package['influxdb'];
  }

  service { 'influxdb':
    ensure => running,
    enable => true,
    require => [
      Package['influxdb'],
      File["/etc/influxdb/influxdb.conf"],
      File["/media/persistent/influxdb"],
    ];
  }
}
