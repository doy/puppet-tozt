class tozt::headscale {
  include tozt::certbot
  include tozt::persistent

  class { "headscale":
    data_dir => "/media/persistent/headscale";
  }

  nginx::site {
    "headscale-tls":
      source => 'puppet:///modules/tozt/nginx/headscale-tls.conf',
      require => Class['certbot'];
    "headscale":
      source => 'puppet:///modules/tozt/nginx/headscale.conf';
  }
}
