class tozt::operatingsystem {
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/tozt/mirrorlist';
  }
}
