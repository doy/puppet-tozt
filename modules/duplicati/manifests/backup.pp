define duplicati::backup($content) {
  include duplicati

  file { "/etc/duplicati/$name.json":
    content => $content,
    mode => '0600',
    require => File['/etc/duplicati'];
  }

  exec { "load backup for $name":
    provider => shell,
    command => "duplicati-client login && duplicati-client create backup /etc/duplicati/$name.json",
    unless => "duplicati-client login && duplicati-client list backups | grep -qF -- '- $name:'",
    require => [
      Class['duplicati'],
      File["/etc/duplicati/$name.json"],
    ];
  }
}
