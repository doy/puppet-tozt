class wireguard {
  package { ["linux-headers", "wireguard-tools"]:
    ensure => installed,
  }
}
