class tarsnap($source=undef, $content=undef) {
  package { 'tarsnap':
    ensure => installed;
  }

  package::makepkg { 'acts':
    ensure => installed,
    require => Package['tarsnap'];
  }

  file {
    '/etc/tarsnap/tarsnap.conf':
      source => 'puppet:///modules/tarsnap/tarsnap.conf';
    '/etc/acts.conf':
      source => $source,
      content => $content;
  }

  cron::job { "acts":
    frequency => "daily",
    source => 'puppet:///modules/tarsnap/acts',
    require => [
      File['/etc/acts.conf'],
      Package::Makepkg['acts'],
    ];
  }

  secret { "/etc/tarsnap/machine-key":
    source => 'tarsnap',
  }
}
