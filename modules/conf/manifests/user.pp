define conf::user($user=$name) {
  $home = base::home($user)

  include conf

  exec { "git clone doy/conf for $user":
    command => "/usr/bin/git clone https://github.com/doy/conf",
    user => $user,
    cwd => $home,
    creates => "$home/conf",
    require => [
      User[$user],
      File[$home],
      Class['git'],
    ];
  }

  exec { "conf make install for $user":
    command => "/usr/bin/make install",
    user => $user,
    cwd => "$home/conf",
    environment => [
      "HOME=$home",
      "PWD=$home/conf",
    ],
    creates => "$home/.zshrc",
    timeout => 1800,
    require => [
      Class['c_toolchain'],
      User[$user],
      Exec["git clone doy/conf for $user"],
      Package["vim"],
      Package["fortune-mod"],
      Package["less"],
    ];
  }

  if $user != 'root' {
    Rust::User[$user] -> Exec["conf make install for $user"]
  }
}
