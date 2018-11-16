class partofme::operatingsystem {
  file { '/etc/mkinitcpio.conf':
    source => 'puppet:///modules/partofme/mkinitcpio.conf',
    notify => Exec['/usr/bin/mkinitcpio -p linux'];
  }

  exec { '/usr/bin/mkinitcpio -p linux':
    refreshonly => true;
  }
}
