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
    ",
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
}
