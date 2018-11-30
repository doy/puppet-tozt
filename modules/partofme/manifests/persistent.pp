class partofme::persistent {
  include cron

  file {
    "/media":
      ensure => directory;
    "/media/persistent":
      ensure => directory,
      require => File["/media"];
    "/etc/cron.weekly/raid-scrub":
      source => 'puppet:///modules/partofme/raid-scrub',
      mode => '0755',
      require => Class['cron'];
    "/etc/cron.hourly/raid-scrub-check":
      source => 'puppet:///modules/partofme/raid-scrub-check',
      mode => '0755',
      require => Class['cron'];
  }

  $fstab_line = "/dev/partofme/data /media/persistent ext4 rw,relatime,noauto 0 2"
  exec { "populate fstab":
    provider => shell,
    command => "echo '${fstab_line}' >> /etc/fstab",
    unless => "/usr/bin/grep -qF '${fstab_line}' /etc/fstab",
    require => File["/media/persistent"],
  }
}
