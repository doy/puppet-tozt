class munin::duplicati {
  file {
    "/usr/lib/munin/plugins/duplicati_":
      source => "puppet:///modules/munin/duplicati_",
      mode => "0755",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati.rb":
      source => "puppet:///modules/munin/duplicati.rb",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_duration.rb":
      source => "puppet:///modules/munin/duplicati_duration.rb",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_file_count.rb":
      source => "puppet:///modules/munin/duplicati_file_count.rb",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_file_size.rb":
      source => "puppet:///modules/munin/duplicati_file_size.rb",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_last_run.rb":
      source => "puppet:///modules/munin/duplicati_last_run.rb",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_duration":
      ensure => link,
      target => "/usr/lib/munin/plugins/duplicati_",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_file_count":
      ensure => link,
      target => "/usr/lib/munin/plugins/duplicati_",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_file_size":
      ensure => link,
      target => "/usr/lib/munin/plugins/duplicati_",
      require => Package["munin-node"],
      before => Service["munin-node"];
    "/usr/lib/munin/plugins/duplicati_last_run":
      ensure => link,
      target => "/usr/lib/munin/plugins/duplicati_",
      require => Package["munin-node"],
      before => Service["munin-node"];
  }
}
