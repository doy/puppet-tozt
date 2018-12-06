class mail::operatingsystem {
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/mail/mirrorlist';
  }
  File['/etc/pacman.d/mirrorlist'] -> Package<| provider == "pacman" |>
}
