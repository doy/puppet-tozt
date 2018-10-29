class tozt::ttrss {
  include tozt::certbot
  include tozt::persistent

  class { "ttrss":
    dbpath => "/media/persistent/ttrss",
    require => Class["tozt::persistent"];
  }

  secret { "/media/persistent/ttrss.htpasswd":
    source => "ttrss",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }

  nginx::site {
    "ttrss-tls":
      source => 'puppet:///modules/tozt/nginx/ttrss-tls.conf',
      require => Class['certbot'];
    "ttrss":
      source => 'puppet:///modules/tozt/nginx/ttrss.conf';
  }
}
