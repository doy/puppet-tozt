class systemd {
  exec { 'systemctl daemon-reload':
    path => '/usr/bin',
    refreshonly => true;
  }
}
