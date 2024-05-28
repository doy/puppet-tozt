class tozt::backups {
  class { 'borgmatic':
    extra_paths => ['/media/persistent'],
    require => Service["tailscaled"];
  }
  class { 'restic::remote':
    extra_paths => ['/media/persistent'];
  }
  Service["tailscaled"] -> Exec["restic init"]
}
