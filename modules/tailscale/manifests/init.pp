class tailscale {
  package { "tailscale":
    ensure => installed;
  }

  service { "tailscaled":
    ensure => running,
    enable => true,
    require => Package['tailscale'];
  }
}
