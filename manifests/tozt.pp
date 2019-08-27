node 'tozt', 'tozt.localdomain' {
  $persistent_data = '/media/persistent'
  include tozt::persistent
  Class['tozt::persistent'] -> Class['base']

  class { 'base':
    extra_script => "
      (cd /home/doy/coding/metabase-utils && git pull)
    ";
  }

  include tozt::operatingsystem
  Class['tozt::operatingsystem'] -> Package<| provider == "pacman" |>

  include tozt::backups
  include tozt::git
  include tozt::metabase
  include tozt::monitoring
  include tozt::munin
  include tozt::pass
  include tozt::paste
  include tozt::services
  include tozt::site
  include tozt::ttrss
}
