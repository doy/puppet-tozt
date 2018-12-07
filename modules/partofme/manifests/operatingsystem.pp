class partofme::operatingsystem {
  file {
    '/etc/mkinitcpio.conf':
      source => 'puppet:///modules/partofme/mkinitcpio.conf',
      notify => Exec['/usr/bin/mkinitcpio -p linux'];
    '/etc/pacman.d/mirrorlist':
      source => 'puppet:///modules/partofme/mirrorlist';
  }

  exec { '/usr/bin/mkinitcpio -p linux':
    refreshonly => true;
  }
}
