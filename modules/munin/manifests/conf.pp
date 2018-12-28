class munin::conf {
  file { '/etc/munin/munin.conf':
    source => 'puppet:///modules/munin/munin.conf';
  }
}
