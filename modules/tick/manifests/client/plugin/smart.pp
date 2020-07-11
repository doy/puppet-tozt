class tick::client::plugin::smart {
  tick::client::plugin { "smart":
    opts => {
      use_sudo => true,
      attributes => true,
      interval => "5m",
      timeout => "2m",
    }
  }

  file { "/etc/sudoers.d/telegraf-smart":
    source => 'puppet:///modules/tick/plugins/smart.sudoers',
    require => Package['sudo'];
  }
}
