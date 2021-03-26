class tozt::backups {
  class { 'borgmatic':
    extra_paths => ['/media/persistent'],
  }
}
