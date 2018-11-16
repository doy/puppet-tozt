class partofme::mdadm {
  file { '/etc/mdadm.conf':
    source => 'puppet:///modules/partofme/mdadm.conf',
    notify => Exec['/usr/bin/mdadm --assemble --scan'];
  }

  exec { '/usr/bin/mdadm --assemble --scan':
    refreshonly => true;
  }
}
