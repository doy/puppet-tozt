class cron {
  file {
    '/etc/cronjobs':
      ensure => directory,
      recurse => true,
      purge => true;
  }

  package { ["cronie", "msmtp"]:
    ensure => absent;
  }

  file {
    '/etc/msmtprc':
      ensure => absent;
    '/etc/aliases':
      ensure => absent;
  }

  systemd::override { "cronie":
    ensure => absent;
  }

  service { 'cronie':
    ensure => absent;
  }
}
