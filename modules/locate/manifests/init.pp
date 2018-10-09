class locate {
  include cron

  package { "mlocate":
    ensure => installed,
  }

  file {
    '/etc/cron.daily/updatedb':
      source => 'puppet:///modules/locate/updatedb',
      mode => '0755',
      require => [
        Package['mlocate'],
        Class['cron'],
      ];
  }

  exec { "initial updatedb run":
    command => "/etc/cron.daily/updatedb",
    creates => "/var/lib/mlocate/mlocate.db",
    require => [
      File["/etc/cron.daily/updatedb"],
      Package['mlocate'],
    ]
  }
}
