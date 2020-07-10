class tozt::monitoring {
  include tick::client::base_plugins

  tick::client::plugin { "postgresql":
    opts => {
      address => "user=postgres",
    }
  }

  class {
    [
      "tick::client::plugin::certbot",
      "tick::client::plugin::fail2ban",
      "tick::client::plugin::tarsnap",
    ]:
  }
}
