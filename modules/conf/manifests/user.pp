define conf::user($user=$name) {
  $home = base::home($user)

  include conf

  if $user != 'root' {
    package::cargo { "fancy-prompt for $user":
      package => 'fancy-prompt',
      user => $user,
      ensure => installed,
      require => Package["cmake"],
    }
  }

  exec { "git clone doy/conf for $user":
    command => "/usr/bin/git clone git://github.com/doy/conf",
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
    creates => "$home/.vimrc",
    require => [
      Class['cron'],
      Class['c_toolchain'],
      User[$user],
      Exec["git clone doy/conf for $user"],
      Package["vim"],
      Package["fortune-mod"],
      Package["less"],
    ];
  }
}
