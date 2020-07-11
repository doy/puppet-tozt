class duplicati::server {
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

  systemd::override { "duplicati":
    source => 'puppet:///modules/duplicati/override.conf';
  }

  service { 'duplicati':
    ensure => running,
    enable => true,
    subscribe => Systemd::Override['duplicati'],
    require => Package::Makepkg['duplicati-latest'];
  }
}
