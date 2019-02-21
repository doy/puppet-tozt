class mail::backups {
  class { "tarsnap":
    source => "puppet:///modules/mail/acts.conf";
  }
}
