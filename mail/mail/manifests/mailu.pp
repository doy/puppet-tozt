class mail::mailu {
  include mail::persistent
  include docker

  package { [
    "haveged",
    "opendkim-tools",
  ]:
    ensure => installed;
  }

  file {
    "/mailu/docker-compose.yml":
      source => "puppet:///modules/mail/docker-compose.yml",
      require => Class["mail::persistent"];
    "/mailu/.env.tmpl":
      source => "puppet:///modules/mail/env",
      require => Class["mail::persistent"];
    "/mailu/certs":
      ensure => directory,
      require => Class["mail::persistent"];
    "/mailu/dkim":
      ensure => directory,
      require => Class["mail::persistent"];
    "/mailu/certs/dhparam.pem":
      source => "puppet:///modules/mail/dhparam.pem",
      require => File["/mailu/certs"];
    "/mailu/overrides":
      ensure => directory,
      require => Class["mail::persistent"];
    "/mailu/overrides/rspamd":
      ensure => directory,
      require => File["/mailu/overrides"];
    "/mailu/overrides/rspamd/dkim_signing.conf":
      source => "puppet:///modules/mail/dkim_signing.conf",
      require => File["/mailu/overrides/rspamd"];
  }

  exec { "generate dkim keys":
    provider => shell,
    command => "
      opendkim-genkey -s dkim -d new2.tozt.net
      mv dkim.private /mailu/dkim/new2.tozt.net.dkim.key
      mv dkim.txt /mailu/dkim/new2.tozt.net.dkim.pub
    ",
    cwd => "/mailu",
    creates => "/mailu/dkim/new2.tozt.net.dkim.key",
    require => [
      Package["haveged"],
      Package["opendkim-tools"],
      Class["mail::persistent"],
      File["/mailu/dkim"],
    ];
  }

  exec { "generate mailu secret key":
    provider => shell,
    command => "
      echo SECRET_KEY=$(dd if=/dev/urandom bs=64 count=1 status=none | base64 -w 0 | cut -b -16) > /mailu/secret-key
    ",
    creates => "/mailu/secret-key",
    require => [
      Package["haveged"],
      Class["mail::persistent"],
    ]
  }

  exec { "find local ip address":
    provider => shell,
    command => "echo BIND_ADDRESS4=`curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address` > /run/mailu_bind_address",
    creates => "/run/mailu_bind_address";
  }

  exec { "create env file":
    provider => shell,
    command => "cat /mailu/.env.tmpl /mailu/secret-key /run/mailu_bind_address > /mailu/.env",
    creates => "/mailu/.env",
    subscribe => [
      Exec["generate mailu secret key"],
      Exec["find local ip address"],
      File["/mailu/.env.tmpl"],
    ];
  }

  file { "/etc/systemd/system/mailu.service":
    source => "puppet:///modules/mail/service";
  }

  service { "mailu":
    ensure => running,
    require => [
      File["/mailu/docker-compose.yml"],
      Exec["create env file"],
      File["/etc/systemd/system/mailu.service"],
    ]
  }
}
