$default_user = 'doy'
$vpn_ips = {
  'hornet' => '10.49.0.2',
  'mail' => '10.49.0.3',
  'partofme' => '10.49.0.4',
  'phone' => '10.49.0.5',
  'tozt' => '10.49.0.6',
}

Package::Makepkg {
  build_user => $default_user,
}

include systemd
Class["systemd"] -> Service<| |>
