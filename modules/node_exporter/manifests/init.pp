class node_exporter {
  package { "prometheus-node-exporter":
    ensure => installed;
  }

  file {
    "/etc/conf.d/prometheus-node-exporter":
      source => "puppet:///modules/node_exporter/conf",
      require => Package["prometheus-node-exporter"];
    "/etc/prometheus-node-exporter":
      ensure => directory;
    "/etc/prometheus-node-exporter/plugins":
      ensure => directory,
      require => File["/etc/prometheus-node-exporter"];
  }

  service { "prometheus-node-exporter":
    ensure => running,
    enable => true,
    subscribe => [
      Package["prometheus-node-exporter"],
      File["/etc/conf.d/prometheus-node-exporter"],
    ];
  }
}
