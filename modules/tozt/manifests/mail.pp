class tozt::mail {
  include dovecot
  include postfix

  package { ['procmail', 'mutt']:
    ensure => installed;
  }
}
