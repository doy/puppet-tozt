class tozt::git {
  include tozt::certbot

  nginx::site {
    "git-tls":
      source => 'puppet:///modules/tozt/nginx/git-tls.conf',
      require => Class['certbot'];
    "git":
      source => 'puppet:///modules/tozt/nginx/git.conf';
  }
}
