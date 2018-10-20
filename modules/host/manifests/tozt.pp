class host::tozt {
  include host::tozt::users

  Package::Makepkg {
    build_user => 'doy',
  }

  Host::Tozt::User['doy'] -> Package::Makepkg<| build_user == 'doy' |>

  include host::tozt::bootstrap
  include host::tozt::backups
  include host::tozt::git
  include host::tozt::pass
  include host::tozt::site
  include host::tozt::services
  include host::tozt::tools
  include host::tozt::vpn
}
