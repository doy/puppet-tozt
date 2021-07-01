node 'partofme', 'partofme.localdomain' {
  # we don't want to store anything system-related on the persistent disk,
  # since we want it to be encrypted, and we can't really access it at boot
  # time to type in a password
  $persistent_data = undef

  include base

  include partofme::operatingsystem
  Class['partofme::operatingsystem'] -> Package<| provider == "pacman" |>

  include partofme::backups
  include partofme::filesharing
  include partofme::mdadm
  include partofme::monitoring
  include partofme::persistent
  include partofme::pihole
  include partofme::twitch
}
