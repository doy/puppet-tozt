node 'partofme.localdomain' {
  $persistent_data = undef

  include base

  include partofme::backups
  include partofme::samba
}
