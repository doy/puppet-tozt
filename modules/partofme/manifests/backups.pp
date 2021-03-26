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

  include borg
  file {
    "/media/persistent/borg/.ssh/authorized_keys":
      source => 'puppet:///modules/partofme/borg_authorized_keys',
      owner => 'borg',
      group => 'borg',
      mode => '0600',
      require => Class['borg'];
  }

  class { 'borgmatic':
    host => 'localhost';
  }

  package { 'rclone':
    ensure => installed;
  }

  $b2_account = secret::value('b2-account')
  $b2_key = secret::value('b2-key')
  $b2_password = secret::value('b2-password')
  $b2_salt = secret::value('b2-salt')
  file { '/etc/rclone.conf':
    content => template('partofme/rclone.conf');
  }

  cron::job { 'rclone':
    frequency => "daily",
    source => 'puppet:///modules/partofme/rclone-cron',
    require => [
      Package['rclone'],
      File['/etc/rclone.conf'],
    ];
  }
}
