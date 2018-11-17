node 'partofme.localdomain' {
  $persistent_data = undef

  include base

  include partofme::backups
  include partofme::filesharing
  include partofme::mdadm
  include partofme::monitoring
  include partofme::operatingsystem
  include partofme::persistent
}
