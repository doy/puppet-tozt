class borg($home = '/media/persistent/borg') {
  package { 'borg':
    ensure => installed;
  }

  group { 'borg':
    ensure => present;
  }

  user { 'borg':
    ensure => present,
    gid => 'borg',
    home => $home;
  }

  file {
    "/media/persistent/borg/":
      ensure => directory,
      owner => 'borg',
      group => 'borg',
      require => User['borg'];
    "/media/persistent/borg/.ssh":
      ensure => directory,
      owner => 'borg',
      group => 'borg',
      require => User['borg'];
  }

  sshd::configsection { 'borg':
    source => 'puppet:///modules/borg/sshd_config';
  }
}
