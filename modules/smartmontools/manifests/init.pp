class smartmontools {
  package { 'smartmontools':
    ensure => installed;
  }

  file { '/etc/smartd.conf':
    source => 'puppet:///modules/smartmontools/smartd.conf';
  }

  service { 'smartd':
    enable => true,
    ensure => running,
    require => [
      Package['smartmontools'],
      File['/etc/smartd.conf'],
    ]
  }
}
