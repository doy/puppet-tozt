class grafana {
  package { "grafana":
    ensure => installed;
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
