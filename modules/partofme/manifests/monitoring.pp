class partofme::monitoring {
  include node_exporter
  include smartmontools
  include tick::client::base_plugins

  class {
    [
      "tick::client::plugin::rclone",
      "tick::client::plugin::smart",
    ]:
  }
}
