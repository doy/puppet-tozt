define secret($source, $path=$name, $owner=undef, $group=undef, $mode='0600') {
  file { "$path":
    source => "puppet:///modules/secret/$source",
    owner => $owner,
    group => $group,
    mode => $mode,
    show_diff => false,
  }
}
