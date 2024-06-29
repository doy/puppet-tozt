class tozt::backups {
  class { 'restic::remote':
    extra_paths => ['/media/persistent'];
  }
  Service["tailscaled"] -> Exec["restic init"]
}
