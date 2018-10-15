define rust::user($user=$name, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  include rust

  exec { "install and configure stable toolchain for $user":
    provider => "shell",
    command => "rustup default stable",
    user => $user,
    unless => "rustup show active-toolchain | grep -q stable",
    require => [
      Package["rustup"],
      User[$user],
      File["${_home}/.rustup"],
    ],
  }
}
