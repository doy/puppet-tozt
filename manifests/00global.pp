$default_user = 'doy'
$vpn_ips = {
  'hush' => '10.49.0.2',
  'partofme' => '10.49.0.3',
  'phone' => '10.49.0.4',
  'tozt' => '10.49.0.5',
  'mail' => '10.49.0.6',
  'hornet' => '10.49.0.7',
}

Package::Makepkg {
  build_user => $default_user,
}

include systemd
Class["systemd"] -> Service<| |>
