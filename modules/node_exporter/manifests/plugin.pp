define node_exporter::plugin($source=undef, $content=undef, $ensure=undef, $frequency="minutely") {
  file { "/etc/prometheus-node-exporter/plugins/$name":
    ensure => $ensure,
    source => $source,
    content => $content,
    mode => '0755',
    require => File["/etc/prometheus-node-exporter/plugins"];
  }

  cron::job { "node-exporter-${name}":
    ensure => $ensure,
    frequency => $frequency,
    content => template("node_exporter/cron"),
    user => "node_exporter",
    require => [
      Package["prometheus-node-exporter"],
      File["/etc/prometheus-node-exporter/plugins/$name"],
    ];
  }

  exec { "initial run of node-exporter-${name}":
    command => "/etc/cronjobs/node-exporter-${name}",
    user => "node_exporter",
    creates => "/run/prometheus-node-exporter/${name}.prom",
    require => [
      Package["prometheus-node-exporter"],
      Cron::Job["node-exporter-${name}"],
    ];
  }
}
