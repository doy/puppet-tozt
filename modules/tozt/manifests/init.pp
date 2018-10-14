class tozt {
  include tozt::users
  include tozt::persistent

  Package::Makepkg {
    build_user => 'doy',
  }

  include tozt::bootstrap
  include tozt::backups
  include tozt::site
  include tozt::services
  include tozt::tools
  include tozt::vpn
}
