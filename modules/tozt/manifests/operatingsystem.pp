class tozt::operatingsystem {
  include wireguard
  
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/tozt/mirrorlist';
  }
}
