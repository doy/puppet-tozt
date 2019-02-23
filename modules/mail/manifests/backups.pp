class mail::backups {
  class { "tarsnap":
    source => "puppet:///modules/mail/acts.conf";
  }

  $encrypt_passphrase = secret::value('duplicati-encrypt')
  $url = secret::value('duplicati-url')
  duplicati::backup { 'mail':
    content => template('mail/duplicati-mail.json');
  }
}
