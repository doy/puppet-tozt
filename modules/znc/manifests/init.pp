class znc {
  package { 'znc':
    ensure => installed;
  }

  exec { 'znc --makeconf':
    creates => '/var/lib/znc/.znc/configs/znc.conf',
    require => Package['znc'];
  }

  service { 'znc':
    ensure => running,
    require => [
      Package['znc'],
      Exec['znc --makeconf'],
    ];
  }
}
