class tozt::gitea {
  include gitea
  include tozt::certbot
  include tozt::persistent

  nginx::site {
    "git-tls":
      source => 'puppet:///modules/tozt/nginx/gitea-tls.conf',
      require => Class['certbot'];
    "git":
      source => 'puppet:///modules/tozt/nginx/git.conf';
  }
}
