class tozt::metabase {
  include tozt::certbot
  include tozt::persistent
  include metabase

  secret { "/media/persistent/metabase.htpasswd":
    source => "metabase",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }

  nginx::site {
    "metabase-tls":
      source => 'puppet:///modules/tozt/nginx/metabase-tls.conf',
      require => Class['certbot'];
    "metabase":
      source => 'puppet:///modules/tozt/nginx/metabase.conf';
  }

  file {
    "/root/.config/ynab":
      ensure => directory,
      require => Conf::User["root"];
    "/etc/cron.hourly/ynab-export":
      mode => '0755',
      source => "puppet:///modules/tozt/ynab-export",
      require => Exec["clone ynab-export"];
  }

  secret { "/root/.config/ynab/api-key":
    source => "ynab",
    require => File["/root/.config/ynab"];
  }

  exec { "clone ynab-export":
    command => "/usr/bin/git clone git://github.com/doy/ynab-export",
    cwd => "/opt",
    creates => "/opt/ynab-export",
    require => Class['git'];
  }
}
