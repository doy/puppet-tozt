define tick::client::plugin($opts = {}) {
  include tick::client

  file { "/etc/telegraf/telegraf.d/${name}.conf":
    content => template("tick/plugin.conf"),
    require => File["/etc/telegraf/telegraf.d"],
    notify => Service["telegraf"];
  }
}
