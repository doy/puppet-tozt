class doy::conf {
  exec { "git clone doy/conf":
    command => "git clone git://github.com/doy/conf /home/doy/conf",
    user => "doy",
    creates => "/home/doy/conf",
    require => [
      User["doy"],
      Package["git"],
    ];
  }

  exec { "conf make install":
    command => "make install",
    user => "doy",
    cwd => "/home/doy/conf",
    creates => "/home/doy/.vimrc",
    require => [
      User["doy"],
      Exec["git clone doy/conf"],
      Package["vim"],
      Package["make"],
      Package["git"],
      Package["cronie"],
      Package["fortune-mod"],
      Package["less"],
    ],
  }
}
