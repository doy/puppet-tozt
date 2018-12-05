class docker {
  package { "docker-compose":
    ensure => installed;
  }
}
