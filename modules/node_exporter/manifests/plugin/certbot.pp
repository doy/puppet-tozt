class node_exporter::plugin::certbot {
  include node_exporter::python_plugin

  systemd::override { "node-exporter-certbot":
    source => "puppet:///modules/node_exporter/plugins/certbot-override.conf",
    before => Service["node-exporter-certbot"];
  }

  node_exporter::plugin { "certbot":
    source => "puppet:///modules/node_exporter/plugins/certbot",
    root => true,
    require => Class['node_exporter::python_plugin'];
  }
}
