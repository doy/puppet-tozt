class tarsnap($source=undef, $content=undef) {
  include cron

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
    '/etc/cron.daily/acts':
      source => 'puppet:///modules/tarsnap/acts',
      mode => '0755',
      require => [
        File['/etc/acts.conf'],
        Package::Makepkg['acts'],
        Class['cron'],
      ];
  }

  secret { "/etc/tarsnap/machine-key":
    source => 'tarsnap',
  }
}
