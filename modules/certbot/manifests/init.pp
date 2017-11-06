class certbot {
  package { 'certbot':
    ensure => installed;
  }
}
