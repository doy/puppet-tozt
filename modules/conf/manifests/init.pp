class conf {
  include c_toolchain
  include cron
  include git

  package {
    [
      "cmake",
      "fortune-mod",
      "inetutils", # for hostname
      "less",
      "vim",
    ]:
    ensure => installed,
  }
}
