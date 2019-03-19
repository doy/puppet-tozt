class mail::mailu::testing {
  file {
    "/media/persistent/overrides/patch":
      ensure => directory,
      require => File["/media/persistent/overrides"],
      notify => Service["mailu"];
    "/media/persistent/overrides/patch/learn.sieve":
      source => "puppet:///modules/mail/patch/learn.sieve",
      require => File["/media/persistent/overrides/patch"],
      notify => Service["mailu"];
    "/media/persistent/overrides/patch/dovecot.conf":
      source => "puppet:///modules/mail/patch/dovecot.conf",
      require => File["/media/persistent/overrides/patch"],
      notify => Service["mailu"];
    "/media/persistent/overrides/patch/ham":
      source => "puppet:///modules/mail/patch/ham",
      require => File["/media/persistent/overrides/patch"],
      notify => Service["mailu"];
    "/media/persistent/overrides/patch/spam":
      source => "puppet:///modules/mail/patch/spam",
      require => File["/media/persistent/overrides/patch"],
      notify => Service["mailu"];
  }
}
