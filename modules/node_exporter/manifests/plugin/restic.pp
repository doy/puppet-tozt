class node_exporter::plugin::restic {
  include node_exporter::python_plugin

  $_needs_network = $facts['networking']['hostname'] ? {
    'partofme' => false,
    default => true,
  };
  $_needs_persist = $facts['networking']['hostname'] ? {
    'partofme' => true,
    default => false,
  };
  $_after = $facts['networking']['hostname'] ? {
    'partofme' => undef,
    default => ["tailscaled.service", "sys-subsystem-net-devices-tailscale0.device"],
  };

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
