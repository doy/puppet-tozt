class tozt::rss {
  include tozt::certbot

  nginx::site {
    "freshrss-tls":
      source => 'puppet:///modules/tozt/nginx/rss-tls.conf',
      require => Class['certbot'];
    "freshrss":
      source => 'puppet:///modules/tozt/nginx/rss.conf';
  }
}
