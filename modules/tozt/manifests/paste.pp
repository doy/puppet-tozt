class tozt::paste {
  include tozt::certbot
  include tozt::persistent

  file {
    "/media/persistent/paste/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        Class['tozt::persistent'],
        User['doy'],
        Group['doy'],
      ];
    "/home/doy/paste":
      ensure => link,
      target => "/media/persistent/paste/doy",
      owner => 'doy',
      group => 'doy',
      require => [
        User['doy'],
        Group['doy'],
        File["/home/doy"],
      ];
  }

  nginx::vhost { "paste":
    content => file('tozt/nginx/paste');
  }
}
