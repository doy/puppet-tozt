class nginx::service {
  service { 'nginx':
    ensure => running,
    enabled => true;
  }
}
