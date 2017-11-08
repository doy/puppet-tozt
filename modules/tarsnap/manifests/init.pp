class tarsnap {
  package { 'tarsnap':
    ensure => installed;
  }

  package::makepkg { 'acts':
    ensure => installed,
    require => Package['tarsnap'];
  }

  file {
    '/etc/acts.conf':
      source => 'puppet:///modules/tarsnap/acts.conf';
    '/etc/cron.daily/acts':
      source => 'puppet:///modules/tarsnap/acts',
      mode => '0755',
      require => [
        File['/etc/acts.conf'],
        Package::Makepkg['acts'],
        Package['cronie'],
      ];
  }
}
