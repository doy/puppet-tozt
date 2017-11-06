class spamassassin {
  package { 'spamassassin':
    ensure => installed;
  }

  file { '/etc/mail/spamassassin/local.cf':
    source => 'puppet:///modules/spamassassin/local.cf';
  }
}
