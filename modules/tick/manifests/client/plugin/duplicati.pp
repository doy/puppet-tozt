class tick::client::plugin::duplicati {
  file {
    "/etc/telegraf/telegraf.d/duplicati.conf":
      source => 'puppet:///modules/tick/plugins/duplicati.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/duplicati"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/duplicati":
      source => 'puppet:///modules/tick/plugins/duplicati',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
  }
}
