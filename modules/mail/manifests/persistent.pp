class mail::persistent {
  file {
    "/media":
      ensure => directory;
    "/media/persistent":
      ensure => directory,
      require => File["/media"];
  }

  $fstab_line = "/dev/disk/by-id/scsi-0DO_Volume_mail-persistent /media/persistent ext4 rw,relatime 0 2"
  exec { "populate fstab":
    provider => shell,
    command => "echo '${fstab_line}' >> /etc/fstab",
    unless => "/usr/bin/grep -qF '${fstab_line}' /etc/fstab",
    require => File["/media/persistent"];
  }

  exec { "mount /media/persistent":
    provider => shell,
    command => "/usr/bin/mount /media/persistent",
    unless => "grep ' /media/persistent ' /proc/mounts",
    require => [
      File["/media/persistent"],
      Exec["populate fstab"],
    ];
  }
}
