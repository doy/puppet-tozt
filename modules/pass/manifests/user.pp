define pass::user($user=$name, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  include pass

  file { "${_home}/.password-store":
    ensure => directory,
    owner => $user,
    mode => '0700',
    require => [
      User[$user],
      File[$_home],
    ]
  }

  exec { "initialize password-store repository for $user":
    provider => "shell",
    command => "
      pass git init
      pass git remote add origin tozt.net:pass
    ",
    creates => "${_home}/.password-store/.git",
    path => "/usr/bin",
    require => [
      Class['pass'],
      Class['git'],
      File["${_home}/.password-store"],
    ];
  }
}
