define systemd::override($source = undef, $content = undef) {
  include systemd

  file {
    "/etc/systemd/system/${name}.service.d":
      ensure => directory;
    "/etc/systemd/system/${name}.service.d/override.conf":
      source => $source,
      content => $content,
      notify => Exec['/usr/bin/systemctl daemon-reload'],
      require => File["/etc/systemd/system/${name}.service.d"];
  }
}
