class locate {
  package { "mlocate":
    ensure => installed,
  }

  cron::job { "updatedb":
    frequency => "daily",
    source => 'puppet:///modules/locate/updatedb',
    require => Package['mlocate'];
  }

  exec { "initial updatedb run":
    command => "/etc/cron.daily/updatedb",
    creates => "/var/lib/mlocate/mlocate.db",
    require => [
      File["/etc/cron.daily/updatedb"],
      Package['mlocate'],
      Package['godwrap'],
    ]
  }
}
