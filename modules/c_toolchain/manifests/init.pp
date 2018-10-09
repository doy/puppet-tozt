class c_toolchain {
  package {
    [
      "autoconf",
      "automake",
      "gcc",
      "make",
      "pkgconf",
    ]:
    ensure => installed,
  }
}
