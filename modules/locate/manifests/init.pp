class locate {
  include godwrap

  package { "mlocate":
    ensure => installed,
  }

  service { "updatedb.timer":
    ensure => running,
    enable => true,
    require => Package['mlocate'],
  }
}
