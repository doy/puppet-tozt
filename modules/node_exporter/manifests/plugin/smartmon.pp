class node_exporter::plugin::smartmon {
  include node_exporter::python_plugin

  systemd::override { "node-exporter-smartmon":
    source => "puppet:///modules/node_exporter/plugins/smartmon-override.conf",
    before => Service["node-exporter-smartmon"];
  }

  node_exporter::plugin { "smartmon":
    source => "puppet:///modules/node_exporter/plugins/smartmon",
    frequency => "hourly",
    root => true,
    require => Class['node_exporter::python_plugin'];
  }
}
