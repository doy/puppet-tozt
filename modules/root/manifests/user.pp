class root::user {
  user { 'root':
    ensure => 'present',
    shell => '/usr/bin/zsh',
    password => '$6$eL/FXVccr$zBigeOVvTeo0NYzV85X8uodfg..Pc6U.rcYC7DspwfZJzI6AM5yTr4qzkkMzQBIonsiXtpQ.SD33JOOjKlmDo/',
    require => Package['zsh'];
  }
}
