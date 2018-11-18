define package::cargo($package, $user, $ensure) {
  case $ensure {
    'installed': {
      exec { "cargo install $package for $user":
        provider => "shell",
        command => "cargo install $package",
        unless => "cargo install --list | grep -q '^$package'",
        user => $user,
        timeout => 3600,
        require => [
          User[$user],
          Rust::User[$user],
        ];
      }
    }
    'absent': {
      exec { "cargo uninstall $package for $user":
        provider => "shell",
        command => "cargo uninstall $package",
        onlyif => "cargo install --list | grep -q '^$package'",
        user => $user,
        require => [
          User[$user],
          Rust::User[$user],
        ];
      }
    }
    default: {
      fail("unimplemented ensure $ensure")
    }
  }
}
