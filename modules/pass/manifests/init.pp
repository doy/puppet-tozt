class pass {
  include git

  package { "pass":
    ensure => installed,
  }
}
