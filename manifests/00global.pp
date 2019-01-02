$default_user = 'doy'
$vpn_ips = {
  'hush' => '10.19.49.3',
  'partofme' => '10.19.49.4',
  'phone' => '10.19.49.5',
  'tozt' => '10.19.49.6',
  'mail' => '10.19.49.7',
}

Package::Makepkg {
  build_user => $default_user,
}

include systemd
Class["systemd"] -> Service<| |>
