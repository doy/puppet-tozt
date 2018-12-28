define munin::plugin($source=$name) {
  file { "/etc/munin/plugins/$name":
    ensure => link,
    target => "/usr/lib/munin/plugins/$source",
    require => Package['munin-node'];
  }
}
