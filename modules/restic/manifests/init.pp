class restic {
  package { 'restic':
    ensure => installed;
  }

  file {
    "/etc/restic":
      ensure => directory;
  }
}
