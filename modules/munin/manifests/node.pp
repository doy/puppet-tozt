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
      File['/etc/systemd/system/munin-node.service.d/override.conf'],
    ];
  }

  file {
    '/etc/munin/munin-node.conf':
      content => template('munin/munin-node.conf'),
      require => Package['munin-node'];
    '/etc/systemd/system/munin-node.service.d':
      ensure => directory;
    '/etc/systemd/system/munin-node.service.d/override.conf':
      source => 'puppet:///modules/munin/override.conf',
      notify => Exec["/usr/bin/systemctl daemon-reload"],
      require => File["/etc/systemd/system/munin-node.service.d"];
  }
}
