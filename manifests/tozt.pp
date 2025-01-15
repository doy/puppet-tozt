node 'tozt', 'tozt.localdomain' {
  include base
  include tozt::operatingsystem
  include tozt::persistent
  Class['tozt::operatingsystem'] -> Package<| provider == "pacman" |>
  Class['tozt::persistent'] -> Class['base']

  include tozt::backups
  include tozt::bitwarden
  include tozt::git
  include tozt::headscale
  include tozt::monitoring
  include tozt::paste
  include tozt::prometheus
  include tozt::services
  include tozt::site
  include tozt::ttrss
}
