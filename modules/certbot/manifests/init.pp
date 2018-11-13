class certbot($config_dir=undef) {
  if $config_dir {
    $_config_dir = $config_dir
  }
  else {
    $_config_dir = "/etc/letsencrypt"
  }

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
      content => template('certbot/certbot'),
      mode => '0755',
      require => [
        Package['certbot'],
        Class['cron'],
      ];
    "${_config_dir}/renewal-hooks":
      ensure => directory,
      require => Package['certbot'];
    "${_config_dir}/renewal-hooks/deploy":
      ensure => directory,
      require => File["${_config_dir}/renewal-hooks"];
    "${_config_dir}/renewal-hooks/deploy/reload-cert":
      source => 'puppet:///modules/certbot/reload-cert',
      require => File["${_config_dir}/renewal-hooks/deploy"];
    "/usr/local/bin/bootstrap-certbot":
      source => 'puppet:///modules/certbot/bootstrap-certbot',
      mode => '0755';
  }

  exec { "initial certbot run":
    provider => shell,
    command => "/usr/local/bin/bootstrap-certbot ${config_dir}",
    creates => "${_config_dir}/live",
    require => [
      Package["certbot"],
      # not Class["nginx"], because of circular dependencies with nginx::site
      Package["nginx"],
      Package["certbot-nginx"],
      File['/usr/local/bin/bootstrap-certbot'],
    ],
  }
}
