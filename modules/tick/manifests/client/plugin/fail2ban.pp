class tick::client::plugin::fail2ban {
  tick::client::plugin { "fail2ban":
    opts => {
      use_sudo => true,
    }
  }

  file { "/etc/sudoers.d/telegraf-fail2ban":
    source => 'puppet:///modules/tick/plugins/fail2ban.sudoers',
    require => Package['sudo'];
  }
}