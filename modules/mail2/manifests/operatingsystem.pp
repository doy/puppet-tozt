class mail2::operatingsystem {
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/mail2/mirrorlist';
  }
}
