class certbot {
  include nginx

  package { "certbot":
    ensure => installed;
  }

  file {
    "/var/www/certbot":
      ensure => directory,
      require => Package["nginx"];
    "/etc/nginx/sites-available/certbot":
      source => "puppet:///modules/certbot/nginx",
      notify => Service["nginx"],
      require => [
        Package["nginx"],
        File["/var/www/certbot"],
      ];
    "/etc/nginx/sites-enabled/certbot":
      ensure => link,
      target => "../sites-available/certbot",
      notify => Service["nginx"],
      require => Package["nginx"];
  }

  exec { "initial certbot run":
    command => "/usr/bin/certbot certonly -n --agree-tos -m doy@tozt.net --authenticator webroot --webroot-path /var/www/certbot -d newmail.tozt.net",
    creates => "/etc/letsencrypt/live",
    require => [
      Class["nginx"],
      File["/etc/nginx/sites-enabled/certbot"],
      File["/etc/nginx/sites-available/certbot"],
      File["/var/www/certbot"],
      Package["certbot"],
    ];
  }
}
