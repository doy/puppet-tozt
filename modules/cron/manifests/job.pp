define cron::job($frequency, $source = undef, $content = undef, $ensure = undef) {
  require cron

  file {
    "/etc/cronjobs/${name}":
      ensure => $ensure,
      source => $source,
      content => $content,
      mode => '0755',
      require => File["/etc/cronjobs"];
    "/etc/cron.${frequency}/${name}":
      ensure => $ensure,
      content => template('cron/job'),
      mode => '0755',
      require => File["/etc/cronjobs/${name}"];
  }
}
