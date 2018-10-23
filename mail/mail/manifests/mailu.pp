class mail::mailu {
  include mail::persistent
  include docker

  file {
    "/mailu/docker-compose.yml":
      source => "puppet:///modules/mail/docker-compose.yml",
      require => Class["mail::persistent"];
    "/mailu/.env.tmpl":
      source => "puppet:///modules/mail/env",
      require => Class["mail::persistent"];
  }

  secret { "/mailu/secret-key":
    source => "mailu-secret-key",
    require => Class["mail::persistent"];
  }

  exec { "create env file":
    provider => shell,
    command => "
      cat /mailu/.env.tmpl /mailu/secret-key > /mailu/.env
    ",
    refreshonly => true,
    subscribe => [
      Secret["/mailu/secret-key"],
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
