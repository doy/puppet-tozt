class restic {
  package { 'restic-git':
    ensure => installed;
  }
}
