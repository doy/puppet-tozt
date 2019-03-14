class munin::tarsnap {
  file {
    "/usr/lib/munin/plugins/tarsnap":
      source => "puppet:///modules/munin/plugins/tarsnap",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/tarsnap_last_run":
      source => "puppet:///modules/munin/plugins/tarsnap_last_run",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
  }
}
