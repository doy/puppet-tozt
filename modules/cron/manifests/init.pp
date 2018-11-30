class cron {
  package { ["cronie", "opensmtpd"]:
    ensure => installed,
  }

  service { 'cronie':
    ensure => running,
    enable => true,
    require => Package['cronie'];
  }

  service { 'opensmtpd':
    ensure => running,
    enable => true,
    require => Package['opensmtpd'];
  }

  file { '/etc/smtpd/smtpd.conf':
    source => 'puppet:///modules/cron/smtpd.conf';
  }
}
