class mail::mailu {
  include docker

  file {
    "/mailu":
      ensure => directory;
    "/mailu/docker-compose.yml":
      source => "puppet:///modules/mail/docker-compose.yml",
      require => File["/mailu"];
    "/mailu/.env.tmpl":
      source => "puppet:///modules/mail/env",
      require => File["/mailu"];
  }

  secret { "/mailu/secret-key":
    source => "mailu-secret-key",
    require => File["/mailu"];
  }

  exec { "create env file":
    provider => shell,
    command => "
      cat /mailu/.env.tmpl /mailu/secret-key > /mailu/.env
      echo BIND_ADDRESS4=`curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/anchor_ipv4/address` >> /mailu/.env
    ",
    creates => "/mailu/.env",
    require => [
      Secret["/mailu/secret-key"],
      File["/mailu/secret-key"],
      File["/mailu/.env.tmpl"],
    ];
  }
}
