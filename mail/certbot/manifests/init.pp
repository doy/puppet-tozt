class certbot {
  package {
    [
      "certbot",
      "nginx",
      "python-certbot-nginx",
    ]:
      ensure => installed;
  }

  file {
    "/etc/nginx/sites-available/certbot":
      source => "puppet:///modules/certbot/nginx",
      require => Package["nginx"];
    "/etc/nginx/sites-enabled/certbot":
      ensure => link,
      target => "../sites-available/certbot",
      require => Package["nginx"];
    "/var/www/certbot":
      ensure => directory,
      require => Package["nginx"];
    "/etc/nginx/sites-enabled/default":
      ensure => absent,
      require => Package["nginx"];
  }

  exec { "initial certbot run":
    command => "/usr/bin/certbot -n --agree-tos -m doy@tozt.net --nginx -d newmail.tozt.net",
    creates => "/etc/letsencrypt/live",
    require => [
      File["/etc/nginx/sites-enabled/certbot"],
      File["/var/www/certbot"],
      Package["certbot"],
    ],
  }
}
