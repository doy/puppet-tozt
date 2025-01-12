class grafana {
  package { "grafana":
    ensure => installed;
  }

  file {
    "/media/persistent/grafana":
      ensure => directory;
  }

  service { "grafana":
    ensure => running,
    enable => true,
    subscribe => [
      Package["grafana"],
      File["/etc/grafana.ini"],
    ];
  }
}
