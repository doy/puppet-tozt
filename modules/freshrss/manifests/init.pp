class freshrss($data_dir) {
  include podman
  include systemd

  exec { "podman pull docker.io/freshrss/freshrss:latest":
    provider => "shell",
    unless => "podman ps | grep -q freshrss",
    require => Package["podman"];
  }

  file {
    "$data_dir":
      ensure => directory;
    "$data_dir/data":
      ensure => directory;
    "$data_dir/extensions":
      ensure => directory;
  }

  systemd::service { "freshrss":
    content => template("freshrss/freshrss.service"),
  }

  service { "freshrss":
    ensure => running,
    enable => true,
    require => [
      Class["podman"],
      Exec["podman pull docker.io/freshrss/freshrss:latest"],
      Systemd::Service["freshrss"],
    ]
  }
}
