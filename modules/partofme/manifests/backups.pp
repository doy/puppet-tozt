class partofme::backups {
  include duplicati

  syncthing::user { $default_user:
  }
}
