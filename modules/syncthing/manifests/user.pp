define syncthing::user {
  include syncthing

  service { "syncthing@$name":
    enable => true,
    ensure => running;
  }
}
