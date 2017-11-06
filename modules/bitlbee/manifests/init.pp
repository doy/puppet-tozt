class bitlbee {
  package { 'bitlbee':
    ensure => installed;
  }

  package { 'libgcrypt':
    ensure => installed,
    install_options => ["--asdeps"];
  }

  package::makepkg { 'bitlbee-steam-git':
    ensure => installed,
    require => [
      Package['bitlbee'],
      Package['libgcrypt'],
      Package['autoconf'],
      Package['automake'],
    ];
  }

  file { '/etc/bitlbee/bitlbee.conf':
    source => 'puppet:///modules/bitlbee/bitlbee.conf';
  }

  service { 'bitlbee':
    ensure => running,
    require => [
      Package['bitlbee'],
      Package::Makepkg['bitlbee-steam-git'],
      File['/etc/bitlbee/bitlbee.conf'],
    ];
  }
}
