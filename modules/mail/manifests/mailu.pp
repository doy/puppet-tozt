class mail::mailu {
  include mail::persistent
  include docker
  include haveged

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
      opendkim-genkey -s dkim -d new.tozt.net
      mv dkim.private /media/persistent/dkim/new.tozt.net.dkim.key
      mv dkim.txt /media/persistent/dkim/new.tozt.net.dkim.pub
    ",
    cwd => "/media/persistent",
    creates => "/media/persistent/dkim/new.tozt.net.dkim.key",
    require => [
      Class["haveged"],
      Package["opendkim"],
      Class["mail::persistent"],
      File["/media/persistent/dkim"],
    ];
  }

  file { "/etc/systemd/system/mailu.service":
    source => "puppet:///modules/mail/mailu.service",
    notify => Exec["/usr/bin/systemctl daemon-reload"];
  }

  service { "mailu":
    ensure => running,
    enable => true,
    subscribe => [
      File["/media/persistent/docker-compose.yml"],
      Exec["create env file"],
      File["/etc/systemd/system/mailu.service"],
    ];
  }
}
