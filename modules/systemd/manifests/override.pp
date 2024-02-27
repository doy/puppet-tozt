define systemd::override($source = undef, $content = undef, $ensure = undef) {
  include systemd

  case $ensure {
    'absent': {
      file {
        "/etc/systemd/system/${name}.service.d":
          ensure => absent;
        "/etc/systemd/system/${name}.service.d/override.conf":
          ensure => absent,
          notify => [
            Exec['/usr/bin/systemctl daemon-reload'],
            Service["${name}"]
          ];
      }
    }
    default: {
      file {
        "/etc/systemd/system/${name}.service.d":
          ensure => directory;
        "/etc/systemd/system/${name}.service.d/override.conf":
          source => $source,
          content => $content,
          notify => [
            Exec['/usr/bin/systemctl daemon-reload'],
            Service["${name}"]
          ],
          require => File["/etc/systemd/system/${name}.service.d"];
      }
    }
  }
}
