class mail::persistent {
  file {
    "/mailu":
      ensure => directory;
  }

  $fstab_line = "/dev/disk/by-id/scsi-0DO_Volume_mail-persistent /mailu ext4 rw,relatime 0 2"
  exec { "populate fstab":
    provider => shell,
    command => "echo '${fstab_line}' >> /etc/fstab",
    unless => "/usr/bin/grep -qF '${fstab_line}' /etc/fstab",
    require => File["/mailu"];
  }

  exec { "mount /mailu":
    provider => shell,
    command => "/usr/bin/mount /mailu",
    unless => "grep ' /mailu ' /proc/mounts",
    require => [
      File["/mailu"],
      Exec["populate fstab"],
    ];
  }
}
