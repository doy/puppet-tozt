class doy::user {
  user { 'root':
    ensure => 'present',
    password => '$6$eL/FXVccr$zBigeOVvTeo0NYzV85X8uodfg..Pc6U.rcYC7DspwfZJzI6AM5yTr4qzkkMzQBIonsiXtpQ.SD33JOOjKlmDo/';
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
      Group['doy'],
      Package['zsh'],
    ];
  }

  file { '/home/doy':
    ensure => 'directory',
    owner => 'doy',
    group => 'doy',
    mode => '0700',
    require => [
      User['doy'],
      Group['doy'],
    ];
  }
}
