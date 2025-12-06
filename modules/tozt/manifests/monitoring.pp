class tozt::monitoring {
  include node_exporter
  include tick::client::base_plugins

  class {
    [
      "tick::client::plugin::certbot",
      "tick::client::plugin::fail2ban",
    ]:
  }
}
