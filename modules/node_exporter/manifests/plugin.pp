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
    require => File["/etc/prometheus-node-exporter/plugins/$name"];
  }
}
