class mail::operatingsystem {
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/mail/mirrorlist';
  }
}
