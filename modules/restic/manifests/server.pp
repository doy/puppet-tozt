class restic::server($home = '/media/persistent/restic') {
  include podman
  include systemd
  
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

  secret { "/media/persistent/restic/.htpasswd":
    source => 'restic.htpasswd',
    owner => 'restic',
    group => 'restic',
    require => User['restic'];
  }

  exec { "podman pull docker.io/restic/rest-server:latest":
    provider => "shell",
    unless => "podman images | grep -q restic/rest-server",
    require => Package["podman"];
  }

  systemd::service { "restic-rest-server":
    source => 'puppet:///modules/restic/restic-rest-server.service';
  }

  service { "restic-rest-server":
    ensure => running,
    enable => true,
    require => [
      Class["podman"],
      Exec["podman pull docker.io/restic/rest-server:latest"],
      Systemd::Service["restic-rest-server"],
    ];
  }

  sshd::configsection { 'restic':
    source => 'puppet:///modules/restic/sshd_config';
  }
}
