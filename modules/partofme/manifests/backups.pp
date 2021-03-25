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

  user { 'borg':
    home => '/media/persistent/borg';
  }

  file {
    "/media/persistent/borg/.ssh":
      ensure => directory,
      require => User['borg'];
    "/media/persistent/borg/.ssh/authorized_keys":
      source => 'puppet:///modules/partofme/borg_authorized_keys'
      require => File["/media/persistent/borg/.ssh"];
  }

  sshd::configsection { 'borg':
    source => 'puppet:///modules/partofme/sshd_config.borg';
  }
}
