class nftables {
  package { "nftables":
    ensure => installed;
  }

  $banned_ips = secret::value('banned_ips');

  file { "/etc/nftables.conf":
    content => template("nftables/nftables.conf"),
    require => Package['nftables'];
  }

  service { "nftables":
    ensure => running,
    enable => true,
    require => [
      Package['nftables'],
      File['/etc/nftables.conf'],
    ];
  }
}
