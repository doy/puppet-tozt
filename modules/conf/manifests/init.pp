define conf($user=$name, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  exec { "git clone doy/conf for $user":
    command => "/usr/bin/git clone git://github.com/doy/conf",
    user => $user,
    cwd => $_home,
    creates => "$_home/conf",
    require => [
      User[$user],
      Package["git"],
    ];
  }

  exec { "conf make install for $user":
    command => "/usr/bin/make install",
    user => $user,
    cwd => "$_home/conf",
    environment => [
      "HOME=$_home",
      "PWD=$_home/conf",
    ],
    creates => "$_home/.vimrc",
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
    ];
  }
}
