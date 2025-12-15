class restic {
  package { ['restic', 'fuse2']:
    ensure => installed;
  }
}
