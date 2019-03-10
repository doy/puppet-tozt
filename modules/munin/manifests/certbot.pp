class munin::certbot {
  file {
    "/usr/lib/munin/plugins/certbot":
      source => "puppet:///modules/munin/certbot",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
  }
}
