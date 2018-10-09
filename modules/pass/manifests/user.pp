define pass::user($user=$name, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  include pass

  file { "${home}/.password-store":
    ensure => directory,
    owner => $user,
    mode => '0700',
    require => [
      User[$user],
      File[$home],
    ]
  }

  exec { 'initialize password-store repository':
    provider => "shell",
    command => "
      pass git init
      pass git remote add origin tozt.net:pass
    ",
    creates => "${home}/.password-store/.git",
    path => "/usr/bin",
    require => [
      Class['pass'],
      Class['git'],
      File["${home}/.password-store"],
    ];
  }
}
