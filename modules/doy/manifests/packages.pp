class doy::packages {
  package {
    [
      "git",
      "puppet",
      "vim",
      "lsof",
      "zsh",
      "make",
      "cronie",
      "fortune-mod",
      "less",
      "gcc",
    ]:
    ensure => 'installed';
  }
}
