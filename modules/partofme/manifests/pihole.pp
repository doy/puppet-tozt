class partofme::pihole {
  class { "pihole":
    dir => "/media/persistent/pihole",
    server_ip => "192.168.0.128";
  }
}
