class certbot {
  include cron
  include nginx

  package {
    [
      'certbot',
      'certbot-nginx',
    ]:
    ensure => installed;
  }

  file {
    '/etc/cron.daily/certbot':
      source => 'puppet:///modules/certbot/certbot',
      mode => '0755',
      require => [
        Package['certbot'],
        Class['cron'],
      ];
    '/etc/letsencrypt/renewal-hooks':
      ensure => directory,
      require => Package['certbot'];
    '/etc/letsencrypt/renewal-hooks/deploy':
      ensure => directory,
      require => File['/etc/letsencrypt/renewal-hooks'];
    '/etc/letsencrypt/renewal-hooks/deploy/reload-cert':
      source => 'puppet:///modules/certbot/reload-cert',
      require => File['/etc/letsencrypt/renewal-hooks/deploy'];
  }

  exec { "initial certbot run":
    # XXX update to real domain name
    command => "/usr/bin/certbot -n --agree-tos -m doy@tozt.net --nginx -d new.tozt.net",
    creates => "/etc/letsencrypt/live",
    require => [
      Package["certbot"],
      # not Class["nginx"], because of circular dependencies with nginx::site
      Package["nginx"],
      Package["certbot-nginx"],
    ],
  }
}
