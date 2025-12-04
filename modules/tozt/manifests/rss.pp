class tozt::rss {
  include tozt::certbot
  include tozt::persistent

  $data_dir = "/media/persistent/freshrss";

  file { "$data_dir/.htaccess":
    source => 'puppet:///modules/tozt/freshrss-htaccess',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
      File["$data_dir"],
    ];
  }

  secret { "$data_dir/.htpasswd":
    source => "rss",
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
      File["$data_dir"],
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
