class mail::monitoring {
  include tick::client::base_plugins

  class {
    [
      "tick::client::plugin::certbot",
      "tick::client::plugin::fail2ban",
    ]:
  }
}
