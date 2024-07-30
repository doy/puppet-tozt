class logrotate {
  package { "logrotate":
    ensure => installed;
  }

  file { "/etc/logrotate.conf":
    source => 'puppet:///modules/logrotate/logrotate.conf',
    require => Package['logrotate'];
  }

  service { "logrotate.timer":
    ensure => running,
    enable => true,
    require => [
      Package['logrotate'],
      File['/etc/logrotate.conf'],
    ];
  }
}
