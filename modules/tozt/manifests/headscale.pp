class tozt::headscale {
  include tozt::certbot
  include tozt::persistent

  class { "headscale":
    data_dir => "/media/persistent/headscale";
  }

  nginx::vhost { "headscale":
    content => file('tozt/nginx/headscale'),
    prefix => file('nginx/websockets');
  }
}
