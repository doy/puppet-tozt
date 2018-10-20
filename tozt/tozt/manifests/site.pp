class tozt::site {
  include git
  include tozt::certbot
  include tozt::persistent

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

  file {
    "/media/persistent/public_html/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        Class['tozt::persistent'],
        User['doy'],
        Group['doy'],
      ];
    "/home/doy/public_html":
      ensure => link,
      target => "/media/persistent/public_html/doy",
      owner => 'doy',
      group => 'doy',
      require => [
        User['doy'],
        Group['doy'],
        File["/home/doy"],
      ];
  }

  nginx::site {
    "doy-tls":
      source => 'puppet:///modules/tozt/nginx/doy-tls.conf',
      require => Class['certbot'];
    "doy":
      source => 'puppet:///modules/tozt/nginx/doy.conf';
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
}
