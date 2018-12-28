class munin::node {
  include munin::conf

  package { 'munin-node':
    before => Class['munin::conf'];
  }

  service { 'munin-node':
    ensure => running,
    enable => true,
    require => [
      Package['munin-node'],
      File['/etc/munin/munin-conf.d/node'],
    ];
  }

  file { '/etc/munin/munin-conf.d/node':
    content => template('munin/node.conf'),
    require => Package['munin-node'];
  }
}
