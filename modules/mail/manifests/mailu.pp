class mail::mailu {
  include mail::persistent
  include docker

  package { "opendkim":
    ensure => installed;
  }

  file {
    "/media/persistent/dkim":
      ensure => directory,
      require => Class["mail::persistent"];
    "/media/persistent/docker-compose.yml":
      content => template("mail/docker-compose.yml.erb"),
      require => Class["mail::persistent"];
    "/media/persistent/.env.common":
      source => "puppet:///modules/mail/mailu.env",
      require => Class["mail::persistent"];
  }

  cron::job { "learn_spam":
    ensure => absent;
  }

  exec { "generate mailu secret key":
    provider => shell,
    command => "
      echo SECRET_KEY=$(dd if=/dev/urandom bs=64 count=1 status=none | base64 -w 0 | cut -b -16) > /media/persistent/secret-key
    ",
    creates => "/media/persistent/secret-key",
    require => [
      Class["mail::persistent"],
    ]
  }

  exec { "create env file":
    provider => shell,
    command => "cat /media/persistent/.env.common /media/persistent/secret-key > /media/persistent/mailu.env",
    creates => "/media/persistent/mailu.env",
    subscribe => [
      Exec["generate mailu secret key"],
      File["/media/persistent/.env.common"],
    ];
  }

  exec { "generate dkim keys":
    provider => shell,
    command => "
      opendkim-genkey -s dkim -d tozt.net
      mv dkim.private /media/persistent/dkim/tozt.net.dkim.key
      mv dkim.txt /media/persistent/dkim/tozt.net.dkim.pub
    ",
    cwd => "/media/persistent",
    creates => "/media/persistent/dkim/tozt.net.dkim.key",
    require => [
      Package["opendkim"],
      Class["mail::persistent"],
      File["/media/persistent/dkim"],
    ];
  }

  file {
    "/media/persistent/overrides":
      ensure => directory,
      require => Class["mail::persistent"];
    "/media/persistent/overrides/dovecot":
      ensure => directory,
      require => Class["mail::persistent"];
    "/media/persistent/overrides/dovecot/dovecot.conf":
      source => "puppet:///modules/mail/dovecot.conf",
      require => File["/media/persistent/overrides/dovecot"],
      notify => Service["mailu"];
    "/media/persistent/overrides/rspamd":
      ensure => directory,
      require => File["/media/persistent/overrides"];
    "/media/persistent/overrides/rspamd/milter_headers.conf":
      source => "puppet:///modules/mail/milter_headers.conf",
      require => File["/media/persistent/overrides/rspamd"],
      notify => Service["mailu"];
    "/media/persistent/overrides/sieve":
      ensure => absent;
    "/media/persistent/overrides/dovecot/sieve":
      ensure => directory,
      owner => 'mail',
      group => 'mail',
      require => File["/media/persistent/overrides/dovecot"];
  }

  secret { "/media/persistent/overrides/dovecot/sieve/filters.sieve":
    owner => 'mail',
    group => 'mail',
    source => 'sieve',
    require => File["/media/persistent/overrides/dovecot/sieve"],
    notify => Exec["compile sieve scripts"];
  }
  secret { "/media/persistent/overrides/sieve/filters.sieve":
    ensure => absent;
  }

  exec { "compile sieve scripts":
    command => "/usr/bin/docker-compose exec -T -u mail imap sievec /overrides/dovecot/sieve/filters.sieve",
    cwd => "/media/persistent",
    refreshonly => true,
    tries => 12,
    try_sleep => 15,
    require => Service["mailu"];
  }

  systemd::service { "mailu":
    source => "puppet:///modules/mail/mailu.service",
  }

  service { "mailu":
    ensure => running,
    enable => true,
    subscribe => [
      File["/media/persistent/docker-compose.yml"],
      Exec["create env file"],
      Systemd::Service["mailu"],
    ];
  }
}
