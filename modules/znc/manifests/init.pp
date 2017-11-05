class znc {
  package { 'znc':
    ensure => installed;
  }

  exec { 'znc --makeconf':
    creates => '/var/lib/znc/.znc/configs/znc.conf',
    path => '/usr/bin',
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
