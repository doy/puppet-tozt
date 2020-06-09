class partofme::twitch {
  include c_toolchain

  package { ["streamlink", "vlc"]:
    ensure => installed;
  }

  file {
    "/usr/local/bin/twitch":
      mode => "0755",
      source => 'puppet:///modules/partofme/twitch';
    "/usr/local/src/vtmode.c":
      source => 'puppet:///modules/partofme/vtmode.c';
  }

  exec { "compile vtmode":
    command => "/usr/bin/cc /usr/local/src/vtmode.c -o /usr/local/bin/vtmode",
    creates => "/usr/local/bin/vtmode",
    require => [
      File["/usr/local/src/vtmode.c"],
      Class["c_toolchain"],
    ],
  }

  exec { "suid vtmode":
    command => "/usr/bin/chmod u+s /usr/local/bin/vtmode",
    require => Exec["compile vtmode"],
  }
}
