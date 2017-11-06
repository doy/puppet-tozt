class tozt::other_packages {
  package {
    [
      "autoconf",
      "automake",
      "bc",
      "cronie",
      "exa",
      "fd-rs",
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
      "pkg-config",
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
      require => Package['cronie'];
    'haveged':
      ensure => running,
      require => Package['haveged'];
    'ntpd':
      ensure => running,
      require => Package['ntp'];
  }
}
