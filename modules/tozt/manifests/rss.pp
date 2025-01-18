class tozt::rss {
  include tozt::certbot
  include tozt::persistent

  class { "freshrss":
    data_dir => "/media/persistent/freshrss",
    require => Class["tozt::persistent"];
  }

  secret { "/media/persistent/rss.htpasswd":
    source => "rss",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }

  nginx::site {
    "freshrss-tls":
      source => 'puppet:///modules/tozt/nginx/rss-tls.conf',
      require => Class['certbot'];
    "freshrss":
      source => 'puppet:///modules/tozt/nginx/rss.conf';
  }
}
