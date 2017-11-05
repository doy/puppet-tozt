class conf {
  $user = $name
  $home = $user ? {
    'root' => '/root',
    default => "/home/$user",
  }

  exec { "git clone doy/conf for $user":
    command => "/usr/bin/git clone git://github.com/doy/conf",
    user => $user,
    cwd => $home,
    creates => "$home/conf",
    require => [
      User[$user],
      Package["git"],
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
    creates => "$home/.vimrc",
    require => [
      User[$user],
      Exec["git clone doy/conf for $user"],
      Package["vim"],
      Package["make"],
      Package["git"],
      Package["cronie"],
      Package["fortune-mod"],
      Package["less"],
      Package["gcc"],
    ],
  }
}
