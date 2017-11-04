class doy::packages {
  package {
    [
      "git",
      "puppet",
      "vim",
      "lsof",
    ]:
    ensure => 'installed';
  }
}
