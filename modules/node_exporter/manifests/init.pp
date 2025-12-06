class node_exporter {
  package { "prometheus-node-exporter":
    ensure => installed;
  }

  service { "prometheus-node-exporter":
    ensure => running,
    enable => true,
    subscribe => Package["prometheus-node-exporter"];
  }
}
