define rust::user($user=$name) {
  include rust

  exec { "install and configure stable toolchain for $user":
    provider => "shell",
    command => "rustup default stable",
    user => $user,
    unless => "rustup show active-toolchain | grep -q stable",
    timeout => 3600,
    require => [
      Package["rustup"],
      User[$user],
    ],
  }

  exec { "uninstall rust docs":
    provider => "shell",
    command => "rustup component remove rust-docs",
    user => $user,
    onlyif => "rustup component list | grep -q 'rust-docs.*installed'",
    require => [
      Package["rustup"],
      User[$user],
      Exec["install and configure stable toolchain for $user"],
    ],
  }

  exec { "install wasm target":
    provider => "shell",
    command => "rustup target add wasm32-wasip1",
    user => $user,
    unless => "rustup target list | grep -q 'wasm32-wasip1.*installed'",
    require => [
      Package["rustup"],
      User[$user],
      Exec["install and configure stable toolchain for $user"],
    ],
  }
}
