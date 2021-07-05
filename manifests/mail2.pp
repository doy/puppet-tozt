node 'mail2', 'mail2.localdomain' {
  $persistent_data = '/media/persistent'
  include mail2::persistent
  Class['mail2::persistent'] -> Class['base']

  include base

  include mail2::operatingsystem
  Class['mail2::operatingsystem'] -> Package<| provider == "pacman" |>

  include mail2::backups
  include mail2::monitoring
}
