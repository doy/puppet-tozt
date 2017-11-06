class tozt::site {
  nginx::site {
    "blog":
      source => 'puppet:///modules/tozt/nginx/blog.conf';
    "doy":
      source => 'puppet:///modules/tozt/nginx/doy.conf';
    "mail":
      source => 'puppet:///modules/tozt/nginx/mail.conf';
    "paste":
      source => 'puppet:///modules/tozt/nginx/paste.conf';
  }

  file {
    [
      '/home/doy/blog',
      '/home/doy/public_html',
      '/home/doy/paste',
    ]:
    ensure => directory,
    owner => 'doy',
    group => 'doy',
    require => [
      User['doy'],
      Group['doy'],
      File['/home/doy'],
    ];
  }
}
