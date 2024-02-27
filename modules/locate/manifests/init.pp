class locate {
  include godwrap

  package { "mlocate":
    ensure => installed,
  }

  cron::job { "updatedb":
    frequency => "daily",
    ensure => absent;
  }

  service { "updatedb.timer":
    ensure => running,
    enable => true,
    require => Package['mlocate'],
  }
}
