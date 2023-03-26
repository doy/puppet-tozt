$default_user = lookup('default_user')
$vpn_ips = lookup('vpn_ips')
$persistent_data = lookup('persistent_data', undef, undef, undef)

Package::Makepkg {
  build_user => $default_user,
}

include systemd
Class["systemd"] -> Service<| |>
