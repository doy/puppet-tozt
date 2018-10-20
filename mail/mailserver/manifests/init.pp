class mailserver {
  include docker
  include systemd

  exec { "install mailserver docker image":
    command => "/usr/bin/docker pull tvial/docker-mailserver:latest",
    require => Class["docker"];
  }

  file { "/usr/local/share/mailserver":
    ensure => directory;
  }

  exec { "install mailserver repository":
    command => "/usr/bin/git clone git://github.com/tomav/docker-mailserver /usr/local/share/mailserver/git",
    require => File["/usr/local/share/mailserver"];
  }

  file {
    "/usr/local/bin/mailserver-setup":
      ensure => link,
      target => "/usr/local/share/mailserver/git/setup.sh",
      require => Exec["install mailserver repository"];
    "/etc/systemd/system/mailserver.service":
      source => "puppet:///modules/mailserver/service",
      notify => Exec["systemctl daemon-reload"];
  }
}
