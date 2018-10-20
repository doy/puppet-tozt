class host::tozt::paste {
  include host::tozt::certbot
  include host::tozt::persistent

  file {
    "/media/persistent/paste/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        Class['host::tozt::persistent'],
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

  nginx::site {
    "paste-tls":
      source => 'puppet:///modules/tozt/nginx/paste-tls.conf',
      require => Class['certbot'];
    "paste":
      source => 'puppet:///modules/tozt/nginx/paste.conf';
  }
}
