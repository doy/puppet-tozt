class sudo {
  package { "sudo":
    ensure => 'installed';
  }

  file { "/etc/sudoers.d/wheel":
    content => '%wheel ALL=(ALL) ALL';
  }
}
