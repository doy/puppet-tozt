class tick::client::plugin::certbot {
  file {
    "/etc/telegraf/telegraf.d/certbot.conf":
      source => 'puppet:///modules/tick/plugins/certbot.conf',
      require => [
        File["/etc/telegraf/telegraf.d"],
        File["/etc/telegraf/plugins/certbot"],
      ],
      notify => Service["telegraf"];
    "/etc/telegraf/plugins/certbot":
      source => 'puppet:///modules/tick/plugins/certbot',
      mode => '0755',
      require => [
        File['/etc/telegraf/plugins'],
        File['/etc/telegraf/plugins/certbot_inner'],
        File['/etc/sudoers.d/telegraf-certbot'],
      ];
    "/etc/telegraf/plugins/certbot_inner":
      source => 'puppet:///modules/tick/plugins/certbot_inner',
      mode => '0755',
      require => File['/etc/telegraf/plugins'];
    "/etc/sudoers.d/telegraf-certbot":
      source => 'puppet:///modules/tick/plugins/certbot.sudoers',
      require => Package['sudo'];
  }
}
