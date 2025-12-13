class partofme::monitoring {
  include node_exporter
  include node_exporter::base_plugins
  include smartmontools

  class {
    [
      "node_exporter::plugin::raid_scrub_check",
      "node_exporter::plugin::rclone",
      "node_exporter::plugin::smartmon",
    ]:
  }
}
