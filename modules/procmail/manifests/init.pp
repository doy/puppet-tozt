class procmail {
  package { 'procmail':
    ensure => installed;
  }

  file {
    '/etc/procmail':
      ensure => directory;
    '/etc/procmail/mark_as_read':
      source => 'puppet:///modules/procmail/mark_as_read',
      require => File['/etc/procmail'];
    '/etc/procmailrc':
      source => 'puppet:///modules/procmail/procmailrc',
      require => [
        Class['spamassassin'],
        File['/etc/procmail/mark_as_read'],
      ];
  }
}
