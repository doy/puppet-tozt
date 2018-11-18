class partofme::backups {
  include duplicati

  syncthing::user { $::default_user:
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
}
