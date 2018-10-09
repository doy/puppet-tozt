class conf {
  include c_toolchain
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
