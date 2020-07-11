class conf {
  include c_toolchain
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
