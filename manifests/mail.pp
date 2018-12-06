node 'mail', 'mail.localdomain' {
  $persistent_data = '/media/persistent'
  include mail::persistent
  Class['mail::persistent'] -> Class['base']

  include base

  # XXX
  # include mail::backups
  include mail::mailu
  include mail::operatingsystem
  include mail::services
}
