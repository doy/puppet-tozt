class restic::server($home = '/media/persistent/restic') {
  group { 'restic':
    ensure => present;
  }

  user { 'restic':
    ensure => present,
    gid => 'restic',
    home => $home;
  }

  file {
    "/media/persistent/restic/":
      ensure => directory,
      owner => 'restic',
      group => 'restic',
      require => User['restic'];
    "/media/persistent/restic/.ssh":
      ensure => directory,
      owner => 'restic',
      group => 'restic',
      require => User['restic'];
  }

  sshd::configsection { 'restic':
    source => 'puppet:///modules/restic/sshd_config';
  }
}
