class munin::node {
  include munin::conf

  package { 'munin-node':
    before => Class['munin::conf'];
  }

  file { '/etc/munin/munin-conf.d/node':
    content => template('munin/node.conf'),
    require => Package['munin-node'];
  }
}
