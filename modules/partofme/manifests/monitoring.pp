class partofme::monitoring {
  include smartmontools
  include tick::client::base_plugins

  class { "tick::client::plugin::smart": }
}
