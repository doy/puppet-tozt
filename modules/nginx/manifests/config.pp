class nginx::config {
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
    "/etc/nginx/dhparam.pem":
      source => 'puppet:///modules/nginx/dhparam.pem';
  }
}
