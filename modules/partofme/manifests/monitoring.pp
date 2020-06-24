class partofme::monitoring {
  include smartmontools
  include munin::node
  include munin::duplicati
  include munin::archlinux

  file { '/etc/munin/plugin-conf.d/partofme':
    source => 'puppet:///modules/partofme/munin-plugin-conf',
    require => Package['munin-node'],
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

  tick::client::plugin {
    "cpu":
      opts => {
        percpu => true,
        totalcpu => true,
        collect_cpu_time => false,
        report_active => false,
      };
    "disk":
      opts => {
        ignore_fs => ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"],
      };
    [
      "diskio",
      "kernel",
      "mem",
      "processes",
      "swap",
      "system",
    ]:
  }
}
