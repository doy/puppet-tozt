node 'mail', 'mail.localdomain' {
  $persistent_data = '/media/persistent'
  include mail::persistent
  Class['mail::persistent'] -> Class['base']

  include base

  include mail::operatingsystem
  Class['mail::operatingsystem'] -> Package<| provider == "pacman" |>

  # XXX
  # include mail::backups
  include mail::mailu
  include mail::services
}
