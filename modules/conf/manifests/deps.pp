class conf::deps {
  include cron
  include git

  package {
    [
      "cmake",
      "fortune-mod",
      "less",
      "vim",
    ]:
    ensure => installed,
  }
}
