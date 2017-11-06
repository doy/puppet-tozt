class tozt::mail {
  include dovecot
  include postfix
  include spamassassin
  include procmail

  package { 'mutt':
    ensure => installed;
  }
}
