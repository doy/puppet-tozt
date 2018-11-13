class nginx::install {
  package { ['nginx', 'openssl']:
    ensure => installed;
  }
}
