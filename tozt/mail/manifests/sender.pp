class mail::sender {
  package { "msmtp-mta":
    ensure => installed,
  }
}
