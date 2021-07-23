class docker {
  package { "docker-compose":
    ensure => installed;
  }

  service { "docker":
    ensure => running,
    enable => true,
    require => Package["docker-compose"];
  }
}
