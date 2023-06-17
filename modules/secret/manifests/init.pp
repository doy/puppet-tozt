define secret($source=undef, $ensure=undef, $path=$name, $owner=undef, $group=undef, $mode='0600') {
  case $ensure {
    'absent': {
      file { $path:
        ensure => $ensure,
      }
    }
    default: {
      file { $path:
        source => "puppet:///modules/secret/$source",
        owner => $owner,
        group => $group,
        mode => $mode,
        show_diff => false,
      }
    }
  }
}
