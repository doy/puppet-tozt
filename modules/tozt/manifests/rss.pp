class tozt::rss {
  include tozt::certbot
  include tozt::persistent

  class { "freshrss":
    data_dir => "/media/persistent/freshrss",
    require => Class["tozt::persistent"];
  }

  file {
    "/media/persistent/freshrss":
      ensure => directory;
    "/media/persistent/freshrss/data":
      ensure => directory;
    "/media/persistent/freshrss/extensions":
      ensure => directory;
    "/media/persistent/freshrss/.htaccess":
      source => 'puppet:///modules/tozt/freshrss-htaccess',
      require => [
        Class["tozt::persistent"],
        Package['nginx'],
      ];
  }

  secret { "/media/persistent/freshrss/data/.htpasswd":
    source => "rss",
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
