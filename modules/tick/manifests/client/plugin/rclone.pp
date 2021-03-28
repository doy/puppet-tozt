class tick::client::plugin::rclone {
  file {
    "/etc/telegraf/telegraf.d/rclone.conf":
      source => 'puppet:///modules/tick/plugins/rclone.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/rclone"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/rclone":
      source => 'puppet:///modules/tick/plugins/rclone',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
  }
}
