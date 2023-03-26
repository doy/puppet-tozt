node 'mail', 'mail.localdomain' {
  include base
  include mail::operatingsystem
  include mail::persistent
  Class['mail::operatingsystem'] -> Package<| provider == "pacman" |>
  Class['mail::persistent'] -> Class['base']

  include mail::backups
  include mail::mailu
  include mail::monitoring
  include mail::services
}
