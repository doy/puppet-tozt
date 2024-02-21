class headscale($data_dir) {
  package { "headscale":
    ensure => installed;
  }

  file {
    $data_dir:
      ensure => directory;
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
