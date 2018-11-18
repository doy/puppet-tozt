class partofme::backups {
  include duplicati

  syncthing::user { $default_user:
  }

  user { 'duplicati':
    home => '/media/persistent/duplicati',
    password => secret::value('passwd/duplicati'),
    require => Package::Makepkg['duplicati-latest'];
  }

  sshd::configsection { 'duplicati':
    source => 'puppet:///modules/partofme/sshd_config.duplicati';
  }
}
