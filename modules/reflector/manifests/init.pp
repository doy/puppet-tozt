class reflector {
  package { "reflector":
    ensure => installed;
  }

  file { "/etc/xdg/reflector/reflector.conf":
    source => 'puppet:///modules/reflector/reflector.conf',
    require => Package['reflector'];
  }

  service { "reflector.timer":
    ensure => running,
    enable => true,
    require => [
      Package['reflector'],
      File['/etc/xdg/reflector/reflector.conf'],
    ];
  }
}
