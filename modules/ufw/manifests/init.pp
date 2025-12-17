class ufw {
  package { "ufw":
    ensure => installed;
  }

  service { "ufw":
    ensure => running,
    enable => true,
    require => Package["ufw"];
  }
}
