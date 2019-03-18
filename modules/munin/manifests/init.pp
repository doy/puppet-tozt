class munin {
  include systemd

  package { 'munin':
  }

  file {
    '/srv/http/munin':
      ensure => directory,
      owner => 'munin',
      group => 'munin',
      require => Package['munin'];
    '/etc/munin/munin.conf':
      source => 'puppet:///modules/munin/munin.conf',
      require => Package['munin'];
    "/etc/systemd/system/munin-node.service.d":
      ensure => directory;
    '/etc/systemd/system/munin-node.service.d/override.conf':
      source => 'puppet:///modules/munin/override.conf',
      notify => Exec["/usr/bin/systemctl daemon-reload"],
      require => File["/etc/systemd/system/munin-node.service.d"];
  }

  exec { 'install munin crontab':
    command => '/usr/bin/crontab /etc/munin/munin-cron-entry -u munin',
    creates => '/var/spool/cron/munin',
    require => Package['munin'];
  }
}
