class mail::mailu {
  include mail::persistent
  include docker

  package { "haveged":
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
    "/mailu/certs/dhparam.pem":
      source => "puppet:///modules/mail/dhparam.pem",
      require => File["/mailu/certs"];
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

  exec { "create env file":
    provider => shell,
    command => "
      cat /mailu/.env.tmpl /mailu/secret-key > /mailu/.env
      echo BIND_ADDRESS4=`curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address` >> /mailu/.env
    ",
    refreshonly => true,
    subscribe => [
      Exec["generate mailu secret key"],
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
