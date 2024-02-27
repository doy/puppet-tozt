define cron::job($frequency, $source = undef, $content = undef, $ensure = undef) {
  require cron
  require godwrap
  require systemd

  $godwrap_directory = $godwrap::directory;

  file {
    "/etc/cronjobs/${name}":
      ensure => $ensure,
      source => $source,
      content => $content,
      mode => '0755',
      require => File["/etc/cronjobs"];
    "/etc/systemd/system/${name}.service":
      ensure => $ensure,
      content => template('cron/service'),
      mode => '0755',
      require => File["/etc/cronjobs/${name}"],
      notify => Exec['/usr/bin/systemctl daemon-reload'];
    "/etc/systemd/system/${name}.timer":
      ensure => $ensure,
      content => template('cron/timer'),
      mode => '0755',
      require => File["/etc/cronjobs/${name}"],
      notify => Exec['/usr/bin/systemctl daemon-reload'];
    "/etc/cron.${frequency}/${name}":
      ensure => absent;
  }

  case $ensure {
    'absent': {
    }
    default: {
      service { "${name}.timer":
        ensure => running,
        enable => true,
        require => [
          File["/etc/systemd/system/${name}.service"],
          File["/etc/systemd/system/${name}.timer"],
        ];
      }
    }
  }
}
