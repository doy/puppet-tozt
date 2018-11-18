class smartmontools {
  package { 'smartmontools':
    ensure => installed;
  }

  file { '/etc/smartd.conf':
    source => 'puppet:///modules/smartmontools/smartd.conf';
  }

  service { 'smartd':
    ensure => running,
    enable => true,
    require => [
      Package['smartmontools'],
      File['/etc/smartd.conf'],
    ]
  }
}
