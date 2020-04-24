class wireguard {
  package { "wireguard-tools":
    ensure => installed,
  }

  secret { "/etc/wireguard/algo.conf":
    source => "wireguard",
  }

  service { "wg-quick@algo":
    ensure => running,
    enable => true,
    require => [
      Package["wireguard-tools"],
      Secret["/etc/wireguard/algo.conf"],
    ],
  }
}
