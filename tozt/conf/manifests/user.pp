define conf::user($user=$name, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  include conf

  package::cargo { "fancy-prompt for $user":
    package => 'fancy-prompt',
    user => $user,
    ensure => installed,
    require => Package["cmake"],
  }

  exec { "git clone doy/conf for $user":
    command => "/usr/bin/git clone git://github.com/doy/conf",
    user => $user,
    cwd => $_home,
    creates => "$_home/conf",
    require => [
      User[$user],
      File[$_home],
      Class['git'],
    ];
  }

  file { "$_home/conf/.conf-type":
    content => "server",
    require => Exec["git clone doy/conf for $user"];
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
      File["$_home/conf/.conf-type"],
      Class['cron'],
      Class['c_toolchain'],
      User[$user],
      Exec["git clone doy/conf for $user"],
      Package["vim"],
      Package["fortune-mod"],
      Package["less"],
      Package::Cargo["fancy-prompt for $user"],
    ];
  }

  # XXX use the right branch
}
