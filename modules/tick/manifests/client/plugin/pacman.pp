class tick::client::plugin::pacman {
  file {
    "/etc/telegraf/telegraf.d/pacman.conf":
      source => 'puppet:///modules/tick/plugins/pacman.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/pacman"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/pacman":
      source => 'puppet:///modules/tick/plugins/pacman',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
  }
}
