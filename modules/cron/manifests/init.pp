class cron {
  $from = "${facts['networking']['hostname']}-cron"
  $password = secret::value('cron_email_password')

  package { ["cronie", "msmtp"]:
    ensure => installed,
  }

  file {
    '/etc/msmtprc':
      content => template('cron/msmtprc');
    '/etc/aliases':
      content => template('cron/aliases');
    "/etc/cronjobs":
      ensure => directory,
      recurse => true,
      purge => true;
  }

  systemd::override { "cronie":
    source => 'puppet:///modules/cron/override.conf';
  }

  service { 'cronie':
    ensure => running,
    enable => true,
    subscribe => Systemd::Override['cronie'],
    require => Package['cronie'];
  }
}
