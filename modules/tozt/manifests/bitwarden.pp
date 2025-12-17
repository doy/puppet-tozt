class tozt::bitwarden {
  include tozt::certbot

  nginx::vhost { "bitwarden":
    content => file('tozt/nginx/bitwarden'),
    prefix => file('nginx/websockets');
  }
}
