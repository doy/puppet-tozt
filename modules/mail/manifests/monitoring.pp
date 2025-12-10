class mail::monitoring {
  include node_exporter
  include node_exporter::base_plugins

  class {
    [
      "node_exporter::plugin::certbot",
      "node_exporter::plugin::fail2ban",
    ]:
  }
}
