class sshd {
  package { 'openssh':
    ensure => installed;
  }

  service { 'sshd':
    ensure => running,
    enable => true;
  }

  file {
    '/etc/ssh/sshd_config.d':
      ensure => directory,
      require => Package['openssh'];
  }

  sshd::configsection { '00base':
    source => 'puppet:///modules/sshd/00base';
  }

  exec { 'assemble sshd_config':
    provider => 'shell',
    command => 'cd /etc/ssh/sshd_config.d && cat $(ls) > /etc/ssh/sshd_config',
    refreshonly => true;
  }

  File['/etc/ssh/sshd_config.d'] -> Sshd::Configsection<| |>
  Sshd::Configsection<| |> ~> Exec['assemble sshd_config']
  Exec['assemble sshd_config'] ~> Service['sshd']
}
