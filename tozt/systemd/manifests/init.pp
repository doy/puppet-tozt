class systemd {
  exec { "systemctl daemon-reload":
    refreshonly => true;
  }
}
