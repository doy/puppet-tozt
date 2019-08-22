class tozt::metabase {
  include tozt::certbot
  include tozt::persistent
  include metabase

  secret { "/media/persistent/metabase.htpasswd":
    source => "metabase",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }

  nginx::site {
    "metabase-tls":
      source => 'puppet:///modules/tozt/nginx/metabase-tls.conf',
      require => Class['certbot'];
    "metabase":
      source => 'puppet:///modules/tozt/nginx/metabase.conf';
  }
}
