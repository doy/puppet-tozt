define package::cargo($package, $user, $ensure) {
  case $ensure {
    'installed': {
      exec { "cargo install $name":
        provider => "shell",
        command => "cargo install $name",
        unless => "cargo install --list | grep -q '^$name'",
        require => [
          User[$user],
          Rust::User[$user],
        ];
      }
    }
    'absent': {
      exec { "uninstall $name":
        provider => "shell",
        command => "cargo uninstall $name",
        onlyif => "cargo install --list | grep -q '^$name'",
        require => [
          User[$user],
          Rust::User[$user],
        ];
      }
    }
  }
}
