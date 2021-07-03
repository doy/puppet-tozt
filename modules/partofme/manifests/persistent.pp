class partofme::persistent {
  file {
    "/media":
      ensure => directory;
    "/media/persistent":
      ensure => directory,
      require => File["/media"];
  }

  cron::job {
    "raid-scrub":
      frequency => "weekly",
      source => 'puppet:///modules/partofme/raid-scrub';
    "raid-scrub-check":
      frequency => "hourly",
      source => 'puppet:///modules/partofme/raid-scrub-check';
  }

  $fstab_line = "/dev/partofme/data /media/persistent ext4 rw,relatime,noauto 0 2"
  exec { "populate fstab":
    provider => shell,
    command => "echo '${fstab_line}' >> /etc/fstab",
    unless => "/usr/bin/grep -qF '${fstab_line}' /etc/fstab",
    require => File["/media/persistent"],
  }

  file { "/etc/udev/rules.d/99-local.rules":
    source => "puppet:///modules/partofme/99-media-persistent.rules";
  }
}
