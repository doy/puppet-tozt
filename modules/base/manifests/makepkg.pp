class base::makepkg($default_user) {
  Package::Makepkg {
    build_user => $default_user,
  }

  Base::User[$default_user] -> Package::Makepkg<| build_user == $default_user |>
}
