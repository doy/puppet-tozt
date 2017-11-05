class tozt::irc {
  include znc

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
    ];
  }
}
