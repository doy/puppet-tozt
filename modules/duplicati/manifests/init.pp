class duplicati {
  package {
    [
      "gtk-sharp-2",
      "mono",
    ]:
    ensure => installed,
    install_options => ["--asdeps"];
  }

  package::makepkg { 'duplicati-latest':
    ensure => installed,
    require => [
      Package['gtk-sharp-2'],
      Package['mono'],
    ]
  }

  service { 'duplicati':
    ensure => running,
    enable => true,
    require => Package::Makepkg['duplicati-latest'];
  }
}
