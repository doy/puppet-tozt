class systemd {
  exec { "/usr/bin/systemctl daemon-reload":
    refreshonly => true;
  }

  Exec["/usr/bin/systemctl daemon-reload"] -> Service<| |>
}
