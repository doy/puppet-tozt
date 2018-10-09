class cron {
  package { "cronie":
    ensure => installed,
  }

  service { 'cronie':
    ensure => running,
    enable => true,
    require => Package['cronie'];
  }
}
