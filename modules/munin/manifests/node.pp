class munin::node {
  package { 'munin-node':
  }

  service { 'munin-node':
    ensure => running,
    enable => true,
    require => [
      Package['munin-node'],
      File['/etc/munin/munin-conf.d/node'],
    ];
  }

  file { '/etc/munin/munin-node.conf':
    source => 'puppet:///modules/munin/munin-node.conf',
    require => Package['munin-node'];
  }
}
