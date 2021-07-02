class tozt::backups {
  class { 'borgmatic':
    extra_paths => ['/media/persistent'],
    require => Class["base::vpn"];
  }
}
