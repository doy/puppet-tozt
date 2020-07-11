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
  }

  systemd::override { "cronie":
    source => 'puppet:///modules/cron/override.conf';
  }

  service { 'cronie':
    ensure => running,
    enable => true,
    require => [
      Package['cronie'],
      Systemd::Override['cronie'],
      Exec["/usr/bin/systemctl daemon-reload"],
    ];
  }
}
