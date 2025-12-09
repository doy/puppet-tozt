class node_exporter::plugin::restic {
  include node_exporter::python_plugin

  node_exporter::plugin { "restic":
    source => "puppet:///modules/node_exporter/plugins/restic",
    frequency => "hourly",
    root => true,
    require => Class['node_exporter::python_plugin'];
  }
}
