class restic::instance($repo, $extra_paths) {
  include restic

  $restic_password = secret::value('restic_password')

  exec { "restic init":
    provider => shell,
    environment => [
      "RESTIC_REPOSITORY=${repo}",
      "RESTIC_PASSWORD=${restic_password}",
    ],
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
}
