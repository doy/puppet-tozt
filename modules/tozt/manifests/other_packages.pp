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
    extra_options => ["--asdeps"],
    require => Package['yajl'];
    ;
  }

  package::makepkg { 'yaourt':
    require => Package::Makepkg['package-query'];
  }
}
