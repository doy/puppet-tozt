class tozt::git {
  include tozt::certbot

  nginx::vhost { "git":
    content => file('tozt/nginx/git');
  }
}
