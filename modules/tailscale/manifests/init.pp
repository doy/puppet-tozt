class tailscale {
  package { "tailscale":
    ensure => installed;
  }

  systemd::override { "tailscaled":
    source => "puppet:///modules/tailscale/tailscaled-override.conf";
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
