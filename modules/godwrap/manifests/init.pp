class godwrap($directory = "/var/lib/godwrap") {
  include go

  package::makepkg { 'godwrap':
    ensure => installed,
    require => Package["go"];
  }

  file {
    $directory:
      ensure => directory;
  }
}
