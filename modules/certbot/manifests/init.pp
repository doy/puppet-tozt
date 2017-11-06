class certbot {
  package { 'certbot':
    ensure => installed;
  }

  file { '/etc/cron.daily/certbot':
    source => 'puppet:///modules/certbot/certbot',
    mode => '0755',
    require => Package['certbot'];
  }
}
