class dkim {
  package { 'opendkim':
    ensure => installed;
  }
}
