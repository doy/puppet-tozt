class c_toolchain {
  package {
    [
      "autoconf",
      "automake",
      "gcc",
      "make",
      "patch",
      "pkgconf",
    ]:
    ensure => installed,
  }
}
