class cron {
  file {
    '/etc/cronjobs':
      ensure => directory,
      recurse => true,
      purge => true;
  }
}
