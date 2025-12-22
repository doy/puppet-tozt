class sudo {
  package { "sudo":
    ensure => 'installed';
  }

  file { "/etc/sudoers.d/wheel":
    content => 'Defaults timestamp_type=global\n%wheel ALL=(ALL) ALL',
    require => Package['sudo'];
  }
}
