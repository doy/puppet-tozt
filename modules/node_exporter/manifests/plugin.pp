define node_exporter::plugin($source=undef, $content=undef, $ensure=undef, $frequency="minutely", $root=false) {
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
    on_boot => true,
    content => template("node_exporter/cron"),
    require => File["/etc/prometheus-node-exporter/plugins/$name"];
  }

  exec { "initial run of node-exporter-${name}":
    command => "/etc/cronjobs/node-exporter-${name}",
    creates => "/run/prometheus-node-exporter/${name}.prom",
    require => Cron::Job["node-exporter-${name}"];
  }
}
