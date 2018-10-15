define package::cargo($package, $user, $ensure, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

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
          File["${_home}/.cargo"],
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
          File["${_home}/.cargo"],
        ];
      }
    }
  }
}
