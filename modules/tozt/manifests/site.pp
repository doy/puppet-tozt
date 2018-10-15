class tozt::site {
  include git

  class { "certbot":
    config_dir => "/media/persistent/certbot",
    require => Class["tozt::persistent"],
  }

  package { "hugo":
    ensure => installed,
  }

  exec { "clone tozt.net":
    command => "/usr/bin/git clone git://github.com/doy/tozt-hugo",
    user => "doy",
    cwd => "/home/doy/coding",
    creates => "/home/doy/coding/tozt-hugo",
    require => [
      Class["git"],
      File["/home/doy/coding"],
    ],
  }

  exec { "generate tozt.net":
    provider => shell,
    command => "
      rm -rf public
      hugo
      mv public /home/doy/site
    ",
    user => "doy",
    cwd => "/home/doy/coding/tozt-hugo",
    creates => "/home/doy/site",
    require => [
      Exec["clone tozt.net"],
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
      require => Class['certbot'];
    "paste":
      source => 'puppet:///modules/tozt/nginx/paste.conf';
    "blog-tls":
      source => 'puppet:///modules/tozt/nginx/blog-tls.conf',
      require => Class['certbot'];
    "blog":
      source => 'puppet:///modules/tozt/nginx/blog.conf';
  }

  file {
    '/usr/local/bin/hugo-tozt':
      source => 'puppet:///modules/tozt/hugo-tozt',
      mode => '0755';
  }

  # XXX eventually move blog/site/paste onto a separate volume?
}
