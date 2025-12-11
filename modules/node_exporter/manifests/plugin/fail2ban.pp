class node_exporter::plugin::fail2ban {
  include node_exporter::python_plugin

  systemd::override { "node-exporter-fail2ban":
    source => "puppet:///modules/node_exporter/plugins/fail2ban-override.conf",
    before => Service["node-exporter-fail2ban"];
  }

  node_exporter::plugin { "fail2ban":
    source => "puppet:///modules/node_exporter/plugins/fail2ban",
    root => true,
    require => Class['node_exporter::python_plugin'];
  }
}
