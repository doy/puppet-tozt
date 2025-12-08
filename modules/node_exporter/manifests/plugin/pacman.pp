class node_exporter::plugin::pacman {
  node_exporter::plugin { "pacman":
    source => "puppet:///modules/node_exporter/plugins/pacman",
    frequency => "hourly",
  }
}
