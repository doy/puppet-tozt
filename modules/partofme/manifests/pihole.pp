class partofme::pihole {
  class { "pihole":
    dir => "/media/persistent/pihole",
    require => File["/media/persistent"];
  }
}
