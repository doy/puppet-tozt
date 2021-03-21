class teleterm($source) {
  include systemd

  group { "teleterm":
    ensure => present;
  }
  user { "teleterm":
    ensure => present,
    gid => "teleterm",
    system => true,
    home => "/",
    require => Group["teleterm"];
  }

  package { "teleterm":
    ensure => installed,
    source => $source,
    notify => Service["teleterm"];
  }

  systemd::service { "teleterm":
    source => "puppet:///modules/teleterm/teleterm.service",
  }

  service { "teleterm":
    ensure => "running",
    enable => true,
    require => [
      Systemd::Service["teleterm"],
      Exec["/usr/bin/systemctl daemon-reload"],
      User["teleterm"],
      Group["teleterm"],
    ];
  }
}
