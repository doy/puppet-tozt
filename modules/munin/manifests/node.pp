class munin::node {
  package { 'munin-node':
  }

  service { 'munin-node':
    ensure => running,
    enable => true,
    subscribe => [
      Systemd::Override['munin-node'],
      File['/etc/munin/munin-node.conf'],
    ],
    require => Package['munin-node'];
  }

  file { '/etc/munin/munin-node.conf':
    content => template('munin/munin-node.conf'),
    require => Package['munin-node'];
  }

  systemd::override { "munin-node":
    source => 'puppet:///modules/munin/override.conf';
  }
}
