class git::server {
  package {
    [
      "cgit",
      "fcgiwrap",
      "python-markdown",
      "python-pygments",
    ]:
    ensure => installed,
  }

  service { "fcgiwrap.socket":
    ensure => running,
  }
}
