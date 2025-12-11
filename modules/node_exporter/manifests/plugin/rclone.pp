class node_exporter::plugin::rclone {
  include node_exporter::python_plugin

  systemd::override { "node-exporter-rclone":
    source => "puppet:///modules/node_exporter/plugins/rclone-override.conf",
    before => Service["node-exporter-rclone"];
  }

  node_exporter::plugin { "rclone":
    source => "puppet:///modules/node_exporter/plugins/rclone",
    frequency => "00/6:00",
    needs_network => true,
    require => Class['node_exporter::python_plugin'];
  }
}
