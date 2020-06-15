class munin {
  include systemd

  $from = "munin"
  $password = secret::value('munin_email_password')

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
    '/etc/munin/msmtprc':
      content => template('munin/msmtprc'),
      owner => 'munin',
      group => 'munin',
      mode => '0600',
      require => Package['munin'];
  }

  exec { 'install munin crontab':
    command => '/usr/bin/crontab /etc/munin/munin-cron-entry -u munin',
    creates => '/var/spool/cron/munin',
    require => Package['munin'];
  }
}
