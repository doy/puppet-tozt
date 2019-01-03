class tozt::munin {
  include munin

  secret { "/media/persistent/munin.htpasswd":
    source => "munin",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }

  nginx::site {
    "munin-tls":
      source => 'puppet:///modules/tozt/nginx/munin-tls.conf',
      require => Class['certbot'];
    "munin":
      source => 'puppet:///modules/tozt/nginx/munin.conf';
  }
}
