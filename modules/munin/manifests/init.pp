class munin {
  include munin::conf

  package { 'munin':
    before => Class['munin::conf'];
  }

  file {
    '/srv/http/munin':
      ensure => directory,
      owner => 'munin',
      group => 'munin',
      require => Package['munin'];
    '/etc/munin/munin-conf.d/master':
      source => 'puppet:///modules/munin/master.conf',
      require => Package['munin'];
  }
}
