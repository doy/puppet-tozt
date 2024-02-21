class headscale($data_dir) {
  package { "headscale":
    ensure => installed;
  }

  file {
    [$data_dir, "/var/run/headscale"]:
      owner => 'headscale',
      group => 'headscale',
      ensure => directory,
      require => Package['headscale'];
    "/etc/headscale/config.yaml":
      content => template("headscale/config.yaml"),
      require => Package['headscale'];
  }

  systemd::override { "headscale":
      content => template("headscale/override.conf");
  }

  service { "headscale":
    ensure => running,
    enable => true,
    require => [
      File[$data_dir],
      File["/var/run/headscale"],
      File['/etc/headscale/config.yaml'],
      Systemd::Override["headscale"],
      Package['headscale'],
    ];
  }
}
