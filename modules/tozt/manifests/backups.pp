class tozt::backups {
  include tarsnap

  $encrypt_passphrase = secret::value('duplicati-encrypt')
  $url = secret::value('duplicati-url')
  duplicati::backup { 'tozt':
    content => template('tozt/duplicati-tozt.json');
  }
}
