class munin::tarsnap {
  file {
    "/usr/lib/munin/plugins/tarsnap":
      source => "puppet:///modules/munin/tarsnap",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
  }
}
