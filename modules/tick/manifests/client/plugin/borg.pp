class tick::client::plugin::borg {
  file {
    "/etc/telegraf/telegraf.d/borg.conf":
      source => 'puppet:///modules/tick/plugins/borg.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/borg"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/borg":
      source => 'puppet:///modules/tick/plugins/borg',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
    "/etc/sudoers.d/telegraf-borg":
      source => 'puppet:///modules/tick/plugins/borg.sudoers',
      require => Package['sudo'];
  }
}
