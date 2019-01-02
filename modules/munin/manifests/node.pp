class munin::node {
  package { 'munin-node':
  }

  service { 'munin-node':
    ensure => running,
    enable => true,
    require => Package['munin-node'],
    subscribe => File['/etc/munin/munin-node.conf'];
  }

  file { '/etc/munin/munin-node.conf':
    content => template('munin/munin-node.conf'),
    require => Package['munin-node'];
  }
}
