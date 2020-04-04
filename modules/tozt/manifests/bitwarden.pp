class tozt::bitwarden {
  include tozt::certbot
  include tozt::persistent

  class { "bitwarden::server":
    data_dir => "/media/persistent/bitwarden";
  }

  nginx::site {
    "bitwarden-tls":
      source => 'puppet:///modules/tozt/nginx/bitwarden-tls.conf',
      require => Class['certbot'];
    "bitwarden":
      source => 'puppet:///modules/tozt/nginx/bitwarden.conf';
  }
}
