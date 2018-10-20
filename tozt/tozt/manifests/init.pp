class tozt {
  include tozt::users

  Package::Makepkg {
    build_user => 'doy',
  }

  Tozt::User['doy'] -> Package::Makepkg<| build_user == 'doy' |>

  include tozt::bootstrap
  include tozt::backups
  include tozt::git
  include tozt::pass
  include tozt::site
  include tozt::services
  include tozt::tools
  include tozt::vpn
}
