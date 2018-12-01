node 'tozt', 'tozt.localdomain' {
  $persistent_data = '/media/persistent'
  include tozt::persistent
  Class['tozt::persistent'] -> Class['base']

  include base

  include tozt::backups
  include tozt::git
  include tozt::operatingsystem
  include tozt::pass
  include tozt::paste
  include tozt::services
  include tozt::site
  include tozt::ttrss
}
