class node_exporter::plugin::restic {
  include node_exporter::python_plugin

  $_remote = $facts['networking']['hostname'] ? {
    'partofme' => false,
    default => true,
  };

  systemd::override { "node-exporter-restic":
    content => template("node_exporter/plugins/restic-override.conf"),
    before => Service["node-exporter-restic"];
  }

  node_exporter::plugin { "restic":
    source => "puppet:///modules/node_exporter/plugins/restic",
    frequency => "hourly",
    root => true,
    needs_network => $_needs_network,
    needs_persist => $_needs_persist,
    after => $_after,
    require => Class['node_exporter::python_plugin'];
  }
}
