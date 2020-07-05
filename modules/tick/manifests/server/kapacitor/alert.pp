define tick::server::kapacitor::alert($source) {
  file { "/etc/kapacitor/load/tasks/${name}.tick":
    source => $source,
    require => File["/etc/kapacitor/load/tasks"],
    notify => Service['kapacitor'];
  }
}
