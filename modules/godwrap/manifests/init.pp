class godwrap {
  include go

  package::makepkg { 'godwrap':
    ensure => installed,
    require => Package["go"];
  }

  file {
    "/media/persistent/godwrap":
      ensure => directory;
  }
}
