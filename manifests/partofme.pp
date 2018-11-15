node 'partofme.localdomain' {
  $default_user = 'doy'

  Package::Makepkg {
    build_user => $default_user,
  }

  Base::User[$default_user] -> Package::Makepkg<| build_user == $default_user |>

  class { 'base':
    default_user => $default_user;
  }

  class { 'partofme::backups':
    default_user => $default_user;
  }
}
