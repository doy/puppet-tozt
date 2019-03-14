class munin::archlinux {
  file {
    "/usr/lib/munin/plugins/package_updates":
      source => "puppet:///modules/munin/plugins/package_updates",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
  }
}
