class teleterm {
  include media::persistent
  include systemd

  $version = "0.1.0"

  package { "teleterm":
    ensure => installed,
    source => "/media/persistent/releases/doy/teleterm/arch/teleterm-${version}-1-x86_64.pkg.tar.xz",
    require => File['/media/persistent/releases'];
  }

  file {
    "/etc/systemd/system/teleterm.service":
      source => "puppet:///modules/teleterm/teleterm.service",
      notify => Exec["/usr/bin/systemctl daemon-reload"];
  }

  service { "teleterm":
    ensure => "running",
    enable => true,
    require => [
      File["/etc/systemd/system/teleterm.service"],
      Exec["/usr/bin/systemctl daemon-reload"],
    ];
  }
}
