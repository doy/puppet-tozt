class bitwarden::server($data_dir) {
  include docker
  include systemd

  exec { "docker pull bitwardenrs/server:latest":
    provider => "shell",
    unless => "docker ps | grep -q bitwardenrs",
    require => Service["docker"];
  }

  file {
    $data_dir:
      ensure => directory;
    "/etc/systemd/system/bitwarden.service":
      source => "puppet:///modules/bitwarden/bitwarden.service",
      notify => Exec["/usr/bin/systemctl daemon-reload"];
  }

  service { "bitwarden":
    ensure => running,
    enable => true,
    require => Exec["docker pull bitwardenrs/server:latest"],
    subscribe => File["/etc/systemd/system/bitwarden.service"];
  }
}
