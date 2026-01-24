class gonic {
  package::makepkg { "gonic":
    ensure => installed;
  }

  file { "/var/lib/gonic/config":
    source => "puppet:///modules/gonic/config",
    require => Package::Makepkg["gonic"];
  }

  service { "gonic":
    ensure => running,
    enable => true,
    subscribe => [
      Package::Makepkg["gonic"],
      File["/var/lib/gonic/config"],
    ];
  }
}
