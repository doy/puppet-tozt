class certbot($config_dir=undef) {
  if $config_dir {
    $_config_dir = $config_dir
  }
  else {
    $_config_dir = "/etc/letsencrypt"
  }

  include cron
  include nginx

  $primary_domain = "tozt.net"
  $secondary_domains = [
    "blog.tozt.net",
    "paste.tozt.net",
    "git.tozt.net",
    "rss.tozt.net",
    "metabase.tozt.net",
    "rc-teleterm.tozt.net",
    "bitwarden.tozt.net",
    "influxdb.tozt.net",
    "chronograf.tozt.net",
  ]

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
    "${_config_dir}/renewal-hooks/deploy/00-generate-pfx":
      source => 'puppet:///modules/certbot/generate-pfx',
      mode => '0755',
      require => File["${_config_dir}/renewal-hooks/deploy"];
    "${_config_dir}/renewal-hooks/deploy/10-reload-cert":
      source => 'puppet:///modules/certbot/reload-cert',
      mode => '0755',
      require => File["${_config_dir}/renewal-hooks/deploy"];
    "${_config_dir}/renewal-hooks/deploy/reload-cert":
      ensure => absent;
    "/usr/local/bin/certbot-tozt":
      content => template('certbot/certbot-tozt'),
      mode => '0755';
  }

  exec { "initial certbot run":
    provider => shell,
    command => "/usr/local/bin/certbot-tozt ${config_dir}",
    creates => "${_config_dir}/live",
    require => [
      Package["certbot"],
      # not Class["nginx"], because of circular dependencies with nginx::site
      Package["nginx"],
      Package["certbot-nginx"],
      File['/usr/local/bin/certbot-tozt'],
    ],
  }
}
