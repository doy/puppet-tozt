class grafana {
  package { "grafana":
    ensure => installed;
  }

  file {
    "/media/persistent/grafana":
      owner => 'grafana',
      group => 'grafana',
      ensure => directory,
      require => Package['grafana'];
    "/var/lib/grafana/plugins":
      owner => 'grafana',
      group => 'grafana',
      ensure => directory,
      require => Package['grafana'];
  }

  service { "grafana":
    ensure => running,
    enable => true,
    subscribe => [
      Package["grafana"],
      File["/etc/grafana.ini"],
    ];
  }
}
