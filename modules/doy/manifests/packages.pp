class doy::packages {
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
      "puppet",
      "strace",
      "vim",
      "zsh",
    ]:
    ensure => 'installed';
  }

  exec { "install yaourt":
    command => "/tmp/bootstrap-tozt/install-yaourt",
    creates => "/usr/bin/yaourt";
  }
}
