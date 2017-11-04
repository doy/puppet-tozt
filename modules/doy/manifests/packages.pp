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
}
