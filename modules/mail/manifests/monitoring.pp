class mail::monitoring {
  include node_exporter
  include node_exporter::base_plugins
  include tick::client::base_plugins

  class {
    [
      "node_exporter::plugin::certbot",
      "node_exporter::plugin::fail2ban",
      "tick::client::plugin::certbot",
      "tick::client::plugin::fail2ban",
    ]:
  }
}
