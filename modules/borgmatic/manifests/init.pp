class borgmatic($host = 'partofme.algo', $extra_paths = []) {
  package { 'borgmatic':
    ensure => installed;
  }

  $current_hostname = "${facts['networking']['hostname']}"
  $borgmatic_host = $host
  $borgmatic_passphrase = secret::value('borgmatic_passphrase')
  $escaped_borgmatic_passphrase = regsubst($borgmatic_passphrase, "'", "''", 'G')
  file {
    "/etc/borgmatic":
      ensure => directory;
    "/etc/borgmatic/config.yaml":
      content => template('borgmatic/config.yaml'),
      require => File["/etc/borgmatic"];
  }

  secret { "/etc/borgmatic/borg_ssh_key":
    source => 'borg_ssh_key',
    require => File["/etc/borgmatic"];
  }

  exec { '/usr/bin/borgmatic init --encryption repokey':
    environment => [
      "BORG_PASSPHRASE=${borgmatic_passphrase}",
    ],
    unless => '/usr/bin/borgmatic info > /dev/null',
    require => [
      Package['borgmatic'],
      File['/etc/borgmatic/config.yaml'],
      File['/etc/borgmatic/borg_ssh_key'],
    ]
  }

  service { 'borgmatic.timer':
    ensure => running,
    enable => true,
    require => [
      Package['borgmatic'],
      File['/etc/borgmatic/config.yaml'],
      Exec['/usr/bin/borgmatic init --encryption repokey'],
    ];
  }
}
