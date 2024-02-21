class partofme::operatingsystem {
  include reflector
  include tailscale
  
  file {
    '/etc/mkinitcpio.conf':
      source => 'puppet:///modules/partofme/mkinitcpio.conf',
      notify => Exec['/usr/bin/mkinitcpio -p linux'];
  }

  exec { '/usr/bin/mkinitcpio -p linux':
    refreshonly => true;
  }
}
