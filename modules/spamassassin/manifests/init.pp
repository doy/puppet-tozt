class spamassassin {
  package { 'spamassassin':
    ensure => installed;
  }

  file {
    '/etc/mail/spamassassin/local.cf':
      source => 'puppet:///modules/spamassassin/local.cf';
    '/etc/cron.daily/spamassassin':
      source => 'puppet:///modules/spamassassin/spamassassin',
      mode => '0755',
      require => Package['spamassassin'];
  }
}
