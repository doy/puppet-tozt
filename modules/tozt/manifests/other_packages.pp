class tozt::other_packages {
  package {
    [
      "autoconf",
      "automake",
      "bc",
      "cronie",
      "exa",
      "fortune-mod",
      "fzf",
      "gcc",
      "git",
      "haveged",
      "htop",
      "less",
      "lsof",
      "make",
      "mlocate",
      "ncdu",
      "ntp",
      "pass",
      "pkgconf",
      "puppet",
      "strace",
      "the_silver_searcher",
      "tmux",
      "vim",
      "zsh",
    ]:
    ensure => 'installed';
  }

  package {
    [
      "yajl"
    ]:
    ensure => 'installed',
    install_options => ["--asdeps"];
  }

  package::makepkg { 'package-query':
    ensure => installed,
    asdeps => true,
    require => Package['yajl'];
  }

  package::makepkg { 'yaourt':
    ensure => installed,
    require => Package::Makepkg['package-query'];
  }

  service {
    'cronie':
      ensure => running,
      enable => true,
      require => Package['cronie'];
    'haveged':
      ensure => running,
      enable => true,
      require => Package['haveged'];
    'ntpd':
      ensure => running,
      enable => true,
      require => Package['ntp'];
  }
}
