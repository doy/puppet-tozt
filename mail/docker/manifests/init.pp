class docker {
  package {
    [
      "apt-transport-https",
      "ca-certificates",
      "curl",
      "gnupg2",
      "software-properties-common",
    ]:
      ensure => installed;
  }

  exec { "install docker apt repository":
    provider => shell,
    command => "
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
      add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable\"
      apt-get -yq update
    ",
    unless => "grep -q download.docker.com /etc/apt/sources.list",
    require => [
      Package["apt-transport-https"],
      Package["ca-certificates"],
      Package["curl"],
      Package["gnupg2"],
      Package["software-properties-common"],
    ];
  }

  package { "docker-ce":
    ensure => installed,
    require => Exec["install docker apt repository"];
  }

  exec { "install docker-compose":
    provider => shell,
    command => "
      curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
    ",
    creates => "/usr/local/bin/docker-compose",
    require => Package["curl"];
  }
}
