class partofme::backups {
  syncthing::user { $::default_user:
  }

  $encrypt_passphrase = secret::value('duplicati')
  duplicati::backup { "partofme":
    content => template('partofme/duplicati-partofme.json');
  }

  $cloud_encrypt_passphrase = secret::value('duplicati-cloud')
  $cloud_url = secret::value('duplicati-cloud-url')
  duplicati::backup { "partofme-cloud":
    content => template('partofme/duplicati-partofme-cloud.json');
  }

  file { '/usr/local/bin/sftp-only':
    content => 'exec false',
    mode => '0755';
  }

  user { 'duplicati':
    home => '/media/persistent/duplicati',
    password => secret::value('passwd/duplicati'),
    shell => '/usr/local/bin/sftp-only',
    require => [
      Package::Makepkg['duplicati-latest'],
      File['/usr/local/bin/sftp-only'],
    ];
  }

  sshd::configsection { 'duplicati':
    source => 'puppet:///modules/partofme/sshd_config.duplicati';
  }

  exec { 'allow sftp logins for duplicati':
    provider => 'shell',
    command => 'echo /usr/local/bin/sftp-only >> /etc/shells',
    unless => 'grep -qF /usr/local/bin/sftp-only /etc/shells',
    require => File['/usr/local/bin/sftp-only'];
  }

  #############################

  package { 'borg':
    ensure => installed;
  }

  group { 'borg':
    ensure => present;
  }

  user { 'borg':
    ensure => present,
    gid => 'borg',
    home => '/media/persistent/borg';
  }

  file {
    "/media/persistent/borg/":
      ensure => directory,
      owner => 'borg',
      group => 'borg',
      require => User['borg'];
    "/media/persistent/borg/.ssh":
      ensure => directory,
      owner => 'borg',
      group => 'borg',
      require => User['borg'];
    "/media/persistent/borg/.ssh/authorized_keys":
      source => 'puppet:///modules/partofme/borg_authorized_keys',
      owner => 'borg',
      group => 'borg',
      mode => '0600',
      require => File["/media/persistent/borg/.ssh"];
  }

  sshd::configsection { 'borg':
    source => 'puppet:///modules/partofme/sshd_config.borg';
  }

  package { 'borgmatic':
    ensure => installed;
  }

  $borgmatic_passphrase = secret::value('borgmatic_passphrase')
  file {
    "/etc/borgmatic":
      ensure => directory;
    "/etc/borgmatic/config.yaml":
      content => template('partofme/borgmatic_config.yaml'),
      require => File["/etc/borgmatic"];
  }

  secret { "/media/persistent/borg/.ssh/borg_ssh_key":
    source => 'borg_ssh_key',
    require => File["/media/persistent/borg/.ssh"];
  }

  exec { '/usr/bin/borgmatic init':
    environment => [
      "BORG_PASSPHRASE=${borgmatic_passphrase}",
    ],
    unless => '/usr/bin/borgmatic info > /dev/null',
    require => [
      Package['borgmatic'],
      File['/etc/borgmatic/config.yaml'],
    ]
  }
}
