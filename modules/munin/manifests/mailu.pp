class munin::mailu {
  file {
    "/usr/lib/munin/plugins/mail_count":
      source => "puppet:///modules/munin/plugins/mail_count",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
  }
}
