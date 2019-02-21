class tozt::backups {
  class { "tarsnap":
    source => "puppet:///modules/tozt/acts.conf";
  }

  $encrypt_passphrase = secret::value('duplicati-encrypt')
  $url = secret::value('duplicati-url')
  duplicati::backup { 'tozt':
    content => template('tozt/duplicati-tozt.json');
  }
}
