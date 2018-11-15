class partofme::backups($default_user) {
  include duplicati

  syncthing::user { $default_user:
  }
}
