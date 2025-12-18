class tozt::git {
  include tozt::certbot

  nginx::vhost { "git":
    content => file('tozt/nginx/git'),
    prefix => file('tozt/nginx/git-prefix');
  }
}
