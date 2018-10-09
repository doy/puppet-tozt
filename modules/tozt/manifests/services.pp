class tozt::services {
  package {
    [
      "mlocate",
      "ntp",
    ]:
    ensure => installed,
  }

  service {
    'ntpd':
      ensure => running,
      enable => true,
      require => Package['ntp'];
  }

  # XXX configure mlocate
}
