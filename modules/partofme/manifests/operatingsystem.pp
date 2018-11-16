class partofme::operatingsystem {
  file {
    '/etc/mkinitcpio.conf':
      source => 'puppet:///modules/partofme/mkinitcpio.conf',
      notify => Exec['/usr/bin/mkinitcpio -p linux'];
    '/etc/yaourtrc':
      source => 'puppet:///modules/partofme/yaourtrc';
    '/etc/pacman.d/mirrorlist':
      source => 'puppet:///modules/partofme/mirrorlist';
  }
  File['/etc/pacman.d/mirrorlist'] -> Package<| provider == "pacman" |>

  exec { '/usr/bin/mkinitcpio -p linux':
    refreshonly => true;
  }
}
