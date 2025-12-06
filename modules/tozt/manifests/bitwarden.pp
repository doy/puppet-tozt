class tozt::bitwarden {
  include tozt::certbot

  nginx::site {
    "bitwarden-tls":
      source => 'puppet:///modules/tozt/nginx/bitwarden-tls.conf',
      require => Class['certbot'];
    "bitwarden":
      source => 'puppet:///modules/tozt/nginx/bitwarden.conf';
  }
}
