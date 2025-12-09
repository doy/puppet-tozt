class node_exporter::python_plugin {
  package {
    [
      "python-prometheus_client",
      "python-cryptography",
    ]:
    ensure => installed;
  }
}
