define cron::job($frequency, $source = undef, $content = undef) {
  require cron

  file { "/etc/cron.${frequency}/${name}":
    source => $source,
    content => $content,
    mode => '0755';
  }
}
