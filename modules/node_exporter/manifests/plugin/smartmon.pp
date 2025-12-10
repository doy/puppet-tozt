class node_exporter::plugin::smartmon {
  include node_exporter::python_plugin

  node_exporter::plugin { "smartmon":
    source => "puppet:///modules/node_exporter/plugins/smartmon",
    frequency => "hourly",
    root => true,
    needs_persist => true,
    require => Class['node_exporter::python_plugin'];
  }
}
