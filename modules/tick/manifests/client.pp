class tick::client {
  package::makepkg { 'telegraf-bin':
    ensure => installed;
  }

  $influxdb_token = secret::value('influxdb_token')

  file {
    "/etc/telegraf/telegraf.conf":
      content => template("tick/telegraf.conf"),
      require => Package::Makepkg['telegraf-bin'],
      notify => Service['telegraf'];
    "/etc/telegraf/telegraf.d":
      ensure => directory,
      recurse => true,
      purge => true,
      require => Package::Makepkg['telegraf-bin'];
    "/etc/telegraf/plugins":
      ensure => directory,
      recurse => true,
      purge => true,
      require => Package::Makepkg['telegraf-bin'];
  }

  service { 'telegraf':
    ensure => running,
    enable => true,
    require => Package::Makepkg['telegraf-bin'];
  }
}
