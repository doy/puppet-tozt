class node_exporter::plugin::certbot {
  include node_exporter::python_plugin

  node_exporter::plugin { "certbot":
    source => "puppet:///modules/node_exporter/plugins/certbot",
    root => true,
    needs_persist => true,
    require => Class['node_exporter::python_plugin'];
  }
}
