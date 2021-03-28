class partofme::monitoring {
  include smartmontools
  include tick::client::base_plugins

  class {
    [
      "tick::client::plugin::rclone",
      "tick::client::plugin::smart",
    ]:
  }
}
