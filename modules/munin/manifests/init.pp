class munin {
  package { 'munin':
  }

  file {
    '/srv/http/munin':
      ensure => directory,
      owner => 'munin',
      group => 'munin',
      require => Package['munin'];
    '/etc/munin/munin.conf':
      source => 'puppet:///modules/munin/munin.conf',
      require => Package['munin'];
  }

  exec { 'install munin crontab':
    command => '/usr/bin/crontab /etc/munin/munin-cron-entry -u munin',
    creates => '/var/spool/cron/munin',
    require => Package['munin'];
  }
}
