class partofme::monitoring {
  include smartmontools
  include munin::node
  include munin::duplicati
  include munin::archlinux

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
      'package_updates',
    ]:
  }
}
