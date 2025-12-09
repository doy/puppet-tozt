class node_exporter::plugin::restic {
  include node_exporter::python_plugin

  node_exporter::plugin { "restic":
    source => "puppet:///modules/node_exporter/plugins/restic",
    frequency => "*:00/5",
    root => true,
  }
}
