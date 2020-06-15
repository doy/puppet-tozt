class cron {
  include systemd

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
    '/etc/systemd/system/cronie.service.d':
      ensure => directory;
    '/etc/systemd/system/cronie.service.d/override.conf':
      source => 'puppet:///modules/cron/override.conf',
      require => File['/etc/systemd/system/cronie.service.d'],
      notify => [
        Exec["/usr/bin/systemctl daemon-reload"],
        Service['cronie'],
      ];
  }

  service { 'cronie':
    ensure => running,
    enable => true,
    require => [
      Package['cronie'],
      File['/etc/systemd/system/cronie.service.d/override.conf'],
      Exec["/usr/bin/systemctl daemon-reload"],
    ];
  }
}
