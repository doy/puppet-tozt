class reflector {
  package { "reflector":
    ensure => installed;
  }

  file { "/etc/xdg/reflector/reflector.conf":
    source => 'puppet:///modules/reflector/reflector.conf',
    require => Package['reflector'];
  }

  service { "reflector":
    enable => true,
    require => [
      Package['reflector'],
      File['/etc/xdg/reflector/reflector.conf'],
    ];
  }
}
