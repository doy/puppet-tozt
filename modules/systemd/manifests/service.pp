define systemd::service($source = undef, $content = undef) {
  include systemd

  file { "/usr/lib/systemd/system/${name}.service":
    source => $source,
    content => $content,
    notify => [
      Exec["/usr/bin/systemctl daemon-reload"],
      Service["${name}"],
    ];
  }
}
