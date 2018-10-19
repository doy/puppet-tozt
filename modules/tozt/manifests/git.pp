class tozt::git {
  include git::server
  include tozt::certbot
  include tozt::persistent

  file {
    "/media/persistent/git/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        Class['tozt::persistent'],
        User['doy'],
        Group['doy'],
      ];
    "/home/doy/git":
      ensure => link,
      target => "/media/persistent/git/doy",
      owner => 'doy',
      group => 'doy',
      require => [
        User['doy'],
        Group['doy'],
        File["/home/doy"],
      ];
    "/etc/cgitrc":
      source => "puppet:///modules/tozt/cgitrc";
  }

  secret { "/home/doy/.github":
    source => 'github',
    owner => 'doy',
    group => 'doy',
    require => [
      User['doy'],
      Group['doy'],
      File["/home/doy"],
    ];
  }

  nginx::site {
    "git-tls":
      source => 'puppet:///modules/tozt/nginx/git-tls.conf',
      require => Class['certbot'];
    "git":
      source => 'puppet:///modules/tozt/nginx/git.conf';
  }
}
