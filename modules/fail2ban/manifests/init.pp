class fail2ban {
  package { "fail2ban":
    ensure => installed;
  }

  file {
    "/etc/fail2ban/jail.local":
      source => "puppet:///modules/fail2ban/jail.local",
      notify => Service["fail2ban"],
      require => Package["fail2ban"];
  }

  service { "fail2ban":
    ensure => running,
    enable => true,
    require => [
      File["/etc/fail2ban/jail.local"],
      Package["fail2ban"],
    ];
  }
}
