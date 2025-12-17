define nginx::vhost($content, $prefix=undef, $host=undef) {
  $_host = $host ? {
    undef => "$name.tozt.net",
    default => $host,
  }

  nginx::site { $name:
    content => template('nginx/vhost'),
    require => Class['certbot'];
  }
}
