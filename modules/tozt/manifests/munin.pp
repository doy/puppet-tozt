class tozt::munin {
  include munin

  nginx::site {
    "munin-tls":
      source => 'puppet:///modules/tozt/nginx/munin-tls.conf',
      require => Class['certbot'];
    "munin":
      source => 'puppet:///modules/tozt/nginx/munin.conf';
  }
}
