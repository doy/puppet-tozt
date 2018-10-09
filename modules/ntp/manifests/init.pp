class ntp {
  package { "ntp":
    ensure => installed,
  }

  service { 'ntpd':
    ensure => running,
    enable => true,
    require => Package['ntp'],
  }
}
