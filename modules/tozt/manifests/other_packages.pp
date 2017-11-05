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

  exec { "install yaourt":
    command => "/tmp/bootstrap-tozt/install-yaourt",
    creates => "/usr/bin/yaourt",
    require => [
      Package["git"],
      Package["pkg-config"],
      Package["yajl"],
      User["doy"],
    ];
  }
}
