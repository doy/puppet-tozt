class prometheus {
  package { "prometheus":
    ensure => installed;
  }

  file { "/etc/prometheus/prometheus.yml":
    source => "puppet:///modules/prometheus/prometheus.yml",
    require => Package['prometheus'];
  }

  service { "prometheus":
    ensure => running,
    enable => true,
    require => [
      Package['prometheus'],
      File['/etc/prometheus/prometheus.yml'],
    ];
  }
}
