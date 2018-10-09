define secret($source, $path=$name) {
  file { "$path":
    source => "puppet:///modules/secret/$source",
    mode => '0600',
    show_diff => false,
  }
}
