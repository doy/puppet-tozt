class tick::client::plugin::tarsnap {
  file {
    "/etc/telegraf/telegraf.d/tarsnap.conf":
      source => 'puppet:///modules/tick/plugins/tarsnap.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/tarsnap"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/tarsnap":
      source => 'puppet:///modules/tick/plugins/tarsnap',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
    "/etc/sudoers.d/telegraf-tarsnap":
      source => 'puppet:///modules/tick/plugins/tarsnap.sudoers',
      require => Package['sudo'];
  }
}
