class nginx::config {
  file {
    "/etc/nginx/sites-available":
      ensure => directory,
      recurse => true,
      purge => true;
    "/etc/nginx/sites-enabled":
      ensure => directory,
      recurse => true,
      purge => true;
    "/etc/nginx/ssl":
      source => 'puppet:///modules/nginx/ssl';
    "/etc/nginx/robots.txt":
      source => 'puppet:///modules/nginx/robots.txt';
    "/etc/nginx/mime.types.paste":
      source => 'puppet:///modules/nginx/mime.types.paste';
    "/etc/nginx/nginx.conf":
      source => 'puppet:///modules/nginx/nginx.conf';
    "/etc/nginx/dhparam.pem":
      source => 'puppet:///modules/nginx/dhparam.pem';
  }
}
