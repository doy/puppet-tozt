class restic::instance($repo, $extra_paths, $extra_env = []) {
  include restic

  $restic_password = secret::value('restic_password')

  exec { "restic init":
    provider => shell,
    environment => [
      "RESTIC_REPOSITORY=${repo}",
      "RESTIC_PASSWORD=${restic_password}",
    ] + $extra_env,
    unless => "restic snapshots",
    require => [
      Package['restic'],
    ];
  }

  cron::job { "restic":
    frequency => "daily",
    content => template("restic/restic"),
    require => [
      Package["restic"],
    ]
  }

  systemd::override { "restic":
    source => "puppet:///modules/restic/restic-override.conf";
  }
}
