class tozt::services {
  package {
    [
      "mlocate",
      "ntpd",
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
