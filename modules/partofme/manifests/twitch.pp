class partofme::twitch {
  package { ["streamlink", "vlc"]:
    ensure => installed;
  }

  file { "/usr/local/bin/twitch":
    mode => "0755",
    source => 'puppet:///modules/partofme/twitch';
  }
}
