class mail::monitoring {
  include tick::client::base_plugins

  class {
    [
      "tick::client::plugin::fail2ban",
      "tick::client::plugin::tarsnap",
    ]:
  }
}
