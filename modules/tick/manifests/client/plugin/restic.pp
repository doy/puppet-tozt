class tick::client::plugin::restic {
  file {
    "/etc/telegraf/telegraf.d/restic.conf":
      source => 'puppet:///modules/tick/plugins/restic.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/restic"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/restic":
      source => 'puppet:///modules/tick/plugins/restic',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
    "/etc/sudoers.d/telegraf-restic":
      source => 'puppet:///modules/tick/plugins/restic.sudoers',
      require => Package['sudo'];
  }
}
