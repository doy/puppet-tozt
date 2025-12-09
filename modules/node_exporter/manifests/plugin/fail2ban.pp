class node_exporter::plugin::fail2ban {
  include node_exporter::python_plugin

  node_exporter::plugin { "fail2ban":
    source => "puppet:///modules/node_exporter/plugins/fail2ban",
    root => true,
    require => Class['node_exporter::python_plugin'];
  }
}
