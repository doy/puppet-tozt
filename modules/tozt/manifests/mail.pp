class tozt::mail {
  include dovecot
  include postfix
  include spamassassin
  include procmail
  include dkim

  package { 'mutt':
    ensure => installed;
  }
}
