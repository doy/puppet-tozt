node 'tozt.localdomain' {
  include tozt::persistent
  class { 'base':
    default_user => 'doy',
    persistent_data => '/media/persistent',
  }
  Class['tozt::persistent'] -> Class['base']

  include tozt::backups
  include tozt::git
  include tozt::pass
  include tozt::paste
  include tozt::site
  include tozt::ttrss
  include tozt::vpn
}
