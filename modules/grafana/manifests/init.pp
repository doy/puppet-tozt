class grafana {
  package { "grafana":
    ensure => installed;
  }

  service { "grafana":
    ensure => running,
    enabled => true,
    subscribe => [
      Package["grafana"],
      File["/etc/grafana.ini"],
    ];
  }
}
