node 'tozt.localdomain' {
  $default_user = 'doy'
  $persistent_data = '/media/persistent'

  Package::Makepkg {
    build_user => $default_user,
  }

  Base::User[$default_user] -> Package::Makepkg<| build_user == $default_user |>

  include tozt::persistent
  class { 'base':
    default_user => $default_user,
    persistent_data => $persistent_data,
  }
  Class['tozt::persistent'] -> Class['base']

  include tozt::backups
  include tozt::git
  include tozt::pass
  include tozt::paste
  include tozt::services
  include tozt::site
  include tozt::ttrss
}
