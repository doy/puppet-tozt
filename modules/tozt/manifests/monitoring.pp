class tozt::monitoring {
  include munin::node
  include munin::duplicati

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
      'munin_stats',
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
}
