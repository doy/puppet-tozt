class docker {
  package { ["docker", "docker-compose"]:
    ensure => installed;
  }

  service { "docker":
    ensure => running,
    enable => true,
    require => [
      Package["docker"],
      Package["docker-compose"],
    ];
  }
}
