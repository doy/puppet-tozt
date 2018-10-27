class systemd {
  exec { "/usr/bin/systemctl daemon-reload":
    refreshonly => true;
  }
}
