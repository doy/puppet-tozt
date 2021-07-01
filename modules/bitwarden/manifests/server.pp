class bitwarden::server($data_dir) {
  include podman
  include systemd

  $admin_token = secret::value('bitwarden_admin_token')
  $smtp_password = secret::value('bitwarden_smtp_password')

  exec { "podman pull docker.io/bitwardenrs/server:latest":
    provider => "shell",
    unless => "podman ps | grep -q bitwardenrs",
    require => Package["podman"];
  }

  file { $data_dir:
    ensure => directory;
  }

  systemd::service { "bitwarden":
    content => template("bitwarden/bitwarden.service"),
  }

  service { "bitwarden":
    ensure => running,
    enable => true,
    require => [
      Exec["podman pull docker.io/bitwardenrs/server:latest"],
      Systemd::Service["bitwarden"],
    ]
  }
}
