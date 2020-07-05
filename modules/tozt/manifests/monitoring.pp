class tozt::monitoring {
  include munin::node
  include munin::duplicati
  include munin::tarsnap
  include munin::archlinux
  include munin::certbot

  file { "/etc/munin/plugin-conf.d/tozt":
    source => "puppet:///modules/tozt/munin-plugin-conf",
    require => Package["munin-node"],
    notify => Service["munin-node"];
  }

  munin::plugin {
    [
      'cpu',
      'df',
      'df_inode',
      'forks',
      'load',
      'memory',
      'ntp_offset',
      'processes',
      'swap',
      'threads',
      'uptime',
      'users',
      'vmstat',
    ]:
  }

  munin::plugin {
    [
      'fail2ban',
      'munin_stats',
      'munin_update',
    ]:
  }

  munin::plugin {
    [
      'if_algo',
      'if_eth0',
    ]:
    source => 'if_',
  }

  munin::plugin {
    [
      'if_err_algo',
      'if_err_eth0',
    ]:
    source => 'if_err_',
  }

  munin::plugin {
    [
      'duplicati_duration',
      'duplicati_file_count',
      'duplicati_file_size',
      'duplicati_last_run',
    ]:
  }

  munin::plugin {
    [
      'tarsnap',
      'tarsnap_last_run',
    ]:
  }

  munin::plugin {
    [
      'package_updates',
    ]:
  }

  munin::plugin {
    [
      'certbot',
    ]:
  }

  include tick::client::base_plugins
}
