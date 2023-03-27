class mail::operatingsystem {
  include wireguard
  
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/mail/mirrorlist';
  }
}
