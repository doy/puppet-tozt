class mail::backups {
  class { 'borgmatic':
    extra_paths => ['/media/persistent'],
    require => Service["wg-quick@algo"];
  }
}
