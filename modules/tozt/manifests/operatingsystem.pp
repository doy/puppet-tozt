class tozt::operatingsystem {
  file { '/etc/pacman.d/mirrorlist':
    source => 'puppet:///modules/tozt/mirrorlist';
  }
  File['/etc/pacman.d/mirrorlist'] -> Package<| provider == "pacman" |>
}
