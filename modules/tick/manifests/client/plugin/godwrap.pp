class tick::client::plugin::godwrap {
  file { "/etc/telegraf/telegraf.d/godwrap.conf":
    source => 'puppet:///modules/tick/plugins/godwrap.conf',
    require => File["/etc/telegraf/telegraf.d"],
    notify => Service["telegraf"];
  }
}
