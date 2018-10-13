class tozt::site {
  include certbot
  include git

  package { "hugo":
    ensure => installed,
  }

  exec { "generate tozt.net":
    provider => shell,
    command => "
      cd /tmp
      git clone git://github.com/doy/tozt-hugo
      cd tozt-hugo
      hugo
      mv public /home/doy/site
    ",
    user => "doy",
    creates => "/home/doy/site",
    require => [
      User['doy'],
      File['/home/doy'],
      Package["hugo"],
      Class["git"],
    ],
  }

  nginx::site {
    "doy-tls":
      source => 'puppet:///modules/tozt/nginx/doy-tls.conf',
      require => Class['certbot'];
    "doy":
      source => 'puppet:///modules/tozt/nginx/doy.conf';
    "paste-tls":
      source => 'puppet:///modules/tozt/nginx/paste-tls.conf',
      enabled => false, # XXX
      require => Class['certbot'];
    "paste":
      source => 'puppet:///modules/tozt/nginx/paste.conf';
    "blog-tls":
      source => 'puppet:///modules/tozt/nginx/blog-tls.conf',
      enabled => false, # XXX
      require => Class['certbot'];
    "blog":
      source => 'puppet:///modules/tozt/nginx/blog.conf';
  }

  file {
    [
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

  # XXX eventually move blog/site/paste onto a separate volume?
}
