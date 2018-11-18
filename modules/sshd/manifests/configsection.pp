define sshd::configsection($source) {
  file { "/etc/ssh/sshd_config.d/$name":
    source => $source,
    require => File['/etc/ssh/sshd_config.d'];
  }
}
