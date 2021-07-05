class mail2::backups {
  class { 'borgmatic':
    extra_paths => ['/media/persistent'];
  }
}
