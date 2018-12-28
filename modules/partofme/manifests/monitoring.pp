class partofme::monitoring {
  include smartmontools
  include munin::node

  munin::plugin {
    [
      'cpu',
      'df',
      'df_inode',
      'entropy',
      'forks',
      'fw_packets',
      'interrupts',
      'irqstats',
      'load',
      'memory',
      'ntp_kernel_err',
      'ntp_kernel_pll_freq',
      'ntp_kernel_pll_off',
      'ntp_offset',
      'open_files',
      'open_inodes',
      'proc_pri',
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
      'if_algo',
      'if_enp3s0',
    ]:
      source => 'if_';
  }

  munin::plugin {
    [
      'if_err_algo',
      'if_err_enp3s0',
    ]:
      source => 'if_err_';
  }

  munin::plugin {
    [
      'smart_sda',
      'smart_sdb',
      'smart_sdc',
      'smart_sdd',
    ]:
      source => 'smart_';
  }

  file { '/etc/munin/plugin-conf.d/smart':
    source => 'puppet:///modules/partofme/munin-plugin-smart',
    require => Package['munin-node'];
  }
}
