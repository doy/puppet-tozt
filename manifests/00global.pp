$default_user = 'doy'
$vpn_ips = {
  'hush' => '10.19.49.2',
  'partofme' => '10.19.49.3',
  'phone' => '10.19.49.4',
  'tozt' => '10.19.49.5',
  'mail' => '10.19.49.6',
}

Package::Makepkg {
  build_user => $default_user,
}

include systemd
Class["systemd"] -> Service<| |>
