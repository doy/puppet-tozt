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

  file {
    '/etc/systemd/system/duplicati.service.d':
      ensure => directory;
    '/etc/systemd/system/duplicati.service.d/override.conf':
      source => 'puppet:///modules/duplicati/override.conf',
      notify => Exec['systemctl daemon-reload'],
      require => File['/etc/systemd/system/duplicati.service.d'];
  }

  service { 'duplicati':
    ensure => running,
    enable => true,
    require => [
      Package::Makepkg['duplicati-latest'],
      File['/etc/systemd/system/duplicati.service.d/override.conf'],
      Exec['systemctl daemon-reload'],
    ];
  }

  # XXX configure backups
}
