class sudo {
  package { "sudo":
    ensure => 'installed';
  }

  file { "/etc/sudoers.d/wheel":
    ensure => present,
    content => '%wheel ALL=(ALL) ALL';
  }
}
