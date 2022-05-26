class bitwarden::server($data_dir) {
  include podman
  include systemd

  $admin_token = secret::value('vaultwarden_admin_token')
  $smtp_password = secret::value('vaultwarden_smtp_password')

  exec { "podman pull docker.io/vaultwarden/server:latest":
    provider => "shell",
    unless => "podman ps | grep -q vaultwarden",
    require => Package["podman"];
  }

  file { $data_dir:
    ensure => directory;
  }

  systemd::service { "vaultwarden":
    content => template("bitwarden/vaultwarden.service"),
  }

  service { "vaultwarden":
    ensure => running,
    enable => true,
    require => [
      Class["podman"],
      Exec["podman pull docker.io/vaultwarden/server:latest"],
      Systemd::Service["vaultwarden"],
    ]
  }
}
