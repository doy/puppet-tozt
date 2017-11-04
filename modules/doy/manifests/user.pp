class doy::user {
  file { '/home/doy':
    ensure => 'directory',
    mode => '0700';
  }

  group { 'doy':
    ensure => 'present';
  }

  user { 'doy':
    ensure => 'present',
    gid => 'doy',
    groups => ['wheel'],
    home => '/home/doy',
    shell => '/usr/bin/zsh',
    password => '$6$qOA.wLmjTYa$MIVQkEqcSb3p.YxuhGTRw8fFhto5Lru06JpibfzxO2Ps.ezyvAJeoFHSPInzfjTaNxETl48ERWmQaPuZMAqF1.',
    require => [
      File['/home/doy'],
      Group['doy'],
      Package['zsh'],
    ];
  }
}
