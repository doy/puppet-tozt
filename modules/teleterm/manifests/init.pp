class teleterm($source) {
  include systemd

  group { "teleterm":
    ensure => present;
  }
  user { "teleterm":
    ensure => present,
    gid => "teleterm",
    system => true,
    home => undef,
    require => Group["teleterm"];
  }

  package { "teleterm":
    ensure => installed,
    source => $source,
    notify => Service["teleterm"];
  }

  file {
    "/etc/systemd/system/teleterm.service":
      source => "puppet:///modules/teleterm/teleterm.service",
      notify => Exec["/usr/bin/systemctl daemon-reload"];
  }

  service { "teleterm":
    ensure => "running",
    enable => true,
    require => [
      File["/etc/systemd/system/teleterm.service"],
      Exec["/usr/bin/systemctl daemon-reload"],
      User["teleterm"],
      Group["teleterm"],
    ];
  }
}
