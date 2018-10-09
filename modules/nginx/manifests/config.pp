class nginx::config {
  include haveged

  file {
    "/etc/nginx/sites-available":
      ensure => directory;
    "/etc/nginx/sites-enabled":
      ensure => directory;
    "/etc/nginx/ssl":
      source => 'puppet:///modules/nginx/ssl';
    "/etc/nginx/mime.types.paste":
      source => 'puppet:///modules/nginx/mime.types.paste';
    "/etc/nginx/nginx.conf":
      source => 'puppet:///modules/nginx/nginx.conf';
  }

  exec { 'openssl dhparam -out /etc/nginx/dhparam.pem 4096':
    path => '/usr/bin',
    creates => '/etc/nginx/dhparam.pem',
    timeout => 3600,
    require => Class["haveged"];
  }
}
