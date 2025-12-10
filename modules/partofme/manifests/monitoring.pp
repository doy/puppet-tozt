class partofme::monitoring {
  include node_exporter
  include node_exporter::base_plugins
  include smartmontools
  include tick::client::base_plugins

  class {
    [
      "node_exporter::plugin::rclone",
      "node_exporter::plugin::smartmon",
      "tick::client::plugin::rclone",
      "tick::client::plugin::smart",
    ]:
  }
}
