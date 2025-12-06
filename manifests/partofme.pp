node 'partofme', 'partofme.localdomain' {
  include base
  include partofme::operatingsystem
  Class['partofme::operatingsystem'] -> Package<| provider == "pacman" |>

  include partofme::backups
  include partofme::bitwarden
  include partofme::filesharing
  include partofme::git
  include partofme::mdadm
  include partofme::monitoring
  include partofme::persistent
  include partofme::pihole
  include partofme::prometheus
  include partofme::rss
}
