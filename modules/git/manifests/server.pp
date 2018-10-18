class git::server {
  package {
    [
      "cgit",
      "fcgiwrap",
    ]:
    ensure => installed,
  }

  service { "fcgiwrap.socket":
    ensure => running,
  }
}
