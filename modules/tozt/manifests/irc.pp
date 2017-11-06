class tozt::irc {
  package {
    [
      "bitlbee",
      "weechat",
    ]:
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
}
