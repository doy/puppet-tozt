class tailscale {
  package { "tailscale":
    ensure => installed;
  }

  package { "openbsd-netcat":
    ensure => installed;
  }

  systemd::override { "tailscaled":
    source => "puppet:///modules/tailscale/tailscaled-override.conf",
    require => Package['openbsd-netcat'];
  }

  service { "tailscaled":
    ensure => running,
    enable => true,
    require => [
      Package['tailscale'],
      Systemd::Override['tailscaled'],
    ];
  }
}
