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

  service { "headscale":
    ensure => running,
    enable => true,
    require => [
      File[$data_dir],
      File['/etc/headscale/config.yaml'],
      Package['headscale'],
    ];
  }
}
