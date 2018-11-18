define syncthing::user {
  include syncthing

  service { "syncthing@$name":
    ensure => running,
    enable => true,
    require => Class['syncthing'];
  }
}
