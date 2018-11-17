class partofme::persistent {
  file {
    "/media":
      ensure => directory;
    "/media/persistent":
      ensure => directory,
      require => File["/media"],
  }

  $fstab_line = "/dev/partofme/data /media/persistent ext4 rw,relatime,noauto 0 2"
  exec { "populate fstab":
    provider => shell,
    command => "echo '${fstab_line}' >> /etc/fstab",
    unless => "/usr/bin/grep -qF '${fstab_line}' /etc/fstab",
    require => File["/media/persistent"],
  }
}
