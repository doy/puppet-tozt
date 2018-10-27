class tozt::ttrss {
  include tozt::certbot
  include tozt::persistent

  class ttrss {
    dbpath => "/media/persistent/ttrss",
    require => Class["tozt::persistent"];
  }

  nginx::site {
    "ttrss-tls":
      source => 'puppet:///modules/tozt/nginx/ttrss-tls.conf',
      require => Class['certbot'];
    "ttrss":
      source => 'puppet:///modules/tozt/nginx/ttrss.conf';
  }
}
