define nginx::vhost($content, $prefix=undef, $host="${name}.tozt.net") {
  nginx::site { $name:
    content => template('nginx/vhost'),
    require => Class['certbot'];
  }
}
