class tozt::gitea {
  include gitea
  include tozt::certbot
  include tozt::persistent

  nginx::site {
    "gitea-tls":
      source => 'puppet:///modules/tozt/nginx/gitea-tls.conf',
      require => Class['certbot'];
    "gitea":
      source => 'puppet:///modules/tozt/nginx/gitea.conf';
  }
}
