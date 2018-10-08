class tozt::site {
  nginx::site {
    "blog-tls":
      source => 'puppet:///modules/tozt/nginx/blog-tls.conf',
      enabled => false;
    "blog":
      source => 'puppet:///modules/tozt/nginx/blog.conf';
    "doy-tls":
      source => 'puppet:///modules/tozt/nginx/doy-tls.conf',
      enabled => false;
    "doy":
      source => 'puppet:///modules/tozt/nginx/doy.conf';
    "paste-tls":
      source => 'puppet:///modules/tozt/nginx/paste-tls.conf',
      enabled => false;
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
