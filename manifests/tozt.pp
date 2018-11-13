node 'tozt.localdomain' {
  include tozt::users

  Package::Makepkg {
    build_user => 'doy',
  }

  Tozt::User['doy'] -> Package::Makepkg<| build_user == 'doy' |>

  include tozt::bootstrap
  include tozt::backups
  include tozt::git
  include tozt::misc
  include tozt::pass
  include tozt::paste
  include tozt::site
  include tozt::services
  include tozt::tools
  include tozt::ttrss
  include tozt::vpn
}
