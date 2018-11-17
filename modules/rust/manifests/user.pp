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
}
