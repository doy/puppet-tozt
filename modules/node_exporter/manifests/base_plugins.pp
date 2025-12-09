class node_exporter::base_plugins {
  class {
    [
      "node_exporter::plugin::pacman",
      "node_exporter::plugin::restic",
    ]:
  }
}
