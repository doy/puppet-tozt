class restic::instance($repo, $extra_paths) {
  include restic

  file {
    "/etc/restic":
      ensure => directory;
    "/etc/restic/repository":
      content => $repo,
      require => File["/etc/restic"];
  }

  secret { "/etc/restic/password":
    source => "restic_password",
    require => File["/etc/restic"];
  }

  exec { "restic init --repository-file=/etc/restic/repository --password-file=/etc/restic/password":
    provider => shell,
    unless => "restic snapshots --repository-file=/etc/restic/repository --password-file=/etc/restic/password",
    require => [
      Package['restic'],
      File["/etc/restic/repository"],
      File["/etc/restic/password"],
    ];
  }

  cron::job { "restic":
    frequency => "daily",
    content => template("restic/restic"),
    require => [
      Package["restic"],
      File["/etc/restic/repository"],
      File["/etc/restic/password"],
    ]
  }

  systemd::override { "restic":
    source => "puppet:///modules/restic/restic-override.conf";
  }
}
