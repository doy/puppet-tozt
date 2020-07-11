class munin::node {
  package { 'munin-node':
  }

  service { 'munin-node':
    ensure => running,
    enable => true,
    require => [
      Package['munin-node'],
      Exec['/usr/bin/systemctl daemon-reload'],
    ],
    subscribe => [
      File['/etc/munin/munin-node.conf'],
      Systemd::Override['munin-node'],
    ];
  }

  file { '/etc/munin/munin-node.conf':
    content => template('munin/munin-node.conf'),
    require => Package['munin-node'];
  }

  systemd::override { "munin-node":
    source => 'puppet:///modules/munin/override.conf';
  }
}
