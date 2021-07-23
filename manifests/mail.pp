node 'mail', 'mail.localdomain' {
  $persistent_data = '/media/persistent'
  include mail::persistent
  Class['mail::persistent'] -> Class['base']

  class { 'base':
    extra_script => "
      (cd /media/persistent && sudo podman-compose pull -q)
    ";
  }

  include mail::operatingsystem
  Class['mail::operatingsystem'] -> Package<| provider == "pacman" |>

  include mail::backups
  include mail::mailu
  include mail::monitoring
  include mail::services
}
