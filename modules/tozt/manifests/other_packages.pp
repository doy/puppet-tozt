class tozt::other_packages {
  package {
    [
      "cronie",
      "exa",
      "fd-rs",
      "fortune-mod",
      "gcc",
      "git",
      "less",
      "lsof",
      "make",
      "pkg-config",
      "puppet",
      "strace",
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
}
