class tozt::site {
  nginx::site {
    "blog-tls":
      source => 'puppet:///modules/tozt/nginx/blog-tls.conf',
      enabled => false; # XXX
    "blog":
      source => 'puppet:///modules/tozt/nginx/blog.conf';
    "doy-tls":
      source => 'puppet:///modules/tozt/nginx/doy-tls.conf',
      enabled => false; # XXX
    "doy":
      source => 'puppet:///modules/tozt/nginx/doy.conf';
    "paste-tls":
      source => 'puppet:///modules/tozt/nginx/paste-tls.conf',
      enabled => false; # XXX
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

  # XXX build blog and site
  # XXX eventually move blog/site/paste onto a separate volume?
}
