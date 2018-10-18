class tozt::pass {
  include tozt::persistent

  file {
    "/media/persistent/pass":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        Class['tozt::persistent'],
        User['doy'],
        Group['doy'],
      ];
    "/home/doy/pass":
      ensure => link,
      target => "/media/persistent/pass",
      require => File['/home/doy'];
  }

  exec { "pass git init":
    command => "/usr/bin/git init --bare",
    user => "doy",
    cwd => "/media/persistent/pass",
    creates => "/media/persistent/pass/.git",
    require => [
      Class["git"],
      File["/media/persistent/pass"],
    ],
  }
}
