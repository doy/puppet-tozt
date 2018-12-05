class mail::mailu {
  include mail::persistent
  include docker
  include haveged

  package { "opendkim":
    ensure => installed;
  }

  file {
    "/media/persistent/docker-compose.yml":
      source => "puppet:///modules/mail/docker-compose.yml",
      require => Class["mail::persistent"];
    "/media/persistent/.env.tmpl":
      source => "puppet:///modules/mail/env",
      require => Class["mail::persistent"];
    "/media/persistent/certs":
      ensure => directory,
      require => Class["mail::persistent"];
    "/media/persistent/dkim":
      ensure => directory,
      require => Class["mail::persistent"];
    "/media/persistent/certs/dhparam.pem":
      source => "puppet:///modules/mail/dhparam.pem",
      require => File["/media/persistent/certs"];
    "/media/persistent/overrides":
      ensure => directory,
      require => Class["mail::persistent"];
    "/media/persistent/overrides/rspamd":
      ensure => directory,
      require => File["/media/persistent/overrides"];
    "/media/persistent/overrides/rspamd/dkim_signing.conf":
      source => "puppet:///modules/mail/dkim_signing.conf",
      require => File["/media/persistent/overrides/rspamd"];
  }

  exec { "generate dkim keys":
    provider => shell,
    command => "
      opendkim-genkey -s dkim -d new2.tozt.net
      mv dkim.private /media/persistent/dkim/new2.tozt.net.dkim.key
      mv dkim.txt /media/persistent/dkim/new2.tozt.net.dkim.pub
    ",
    cwd => "/media/persistent",
    creates => "/media/persistent/dkim/new2.tozt.net.dkim.key",
    require => [
      Class["haveged"],
      Package["opendkim"],
      Class["mail::persistent"],
      File["/media/persistent/dkim"],
    ];
  }

  exec { "generate mailu secret key":
    provider => shell,
    command => "
      echo SECRET_KEY=$(dd if=/dev/urandom bs=64 count=1 status=none | base64 -w 0 | cut -b -16) > /media/persistent/secret-key
    ",
    creates => "/media/persistent/secret-key",
    require => [
      Class["haveged"],
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
    command => "cat /media/persistent/.env.tmpl /media/persistent/secret-key /run/mailu_bind_address > /media/persistent/.env",
    unless => "
      test -f /media/persistent/.env &&\
      test -f /run/mailu_bind_address &&\
      grep -F `cat /run/mailu_bind_address` /media/persistent/.env
    ",
    subscribe => [
      Exec["generate mailu secret key"],
      Exec["find local ip address"],
      File["/media/persistent/.env.tmpl"],
    ];
  }

  file { "/etc/systemd/system/mailu.service":
    source => "puppet:///modules/mail/service";
  }

  service { "mailu":
    ensure => running,
    enable => true,
    require => [
      File["/media/persistent/docker-compose.yml"],
      Exec["create env file"],
      File["/etc/systemd/system/mailu.service"],
    ]
  }
}
