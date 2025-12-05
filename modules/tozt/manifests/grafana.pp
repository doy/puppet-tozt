class tozt::grafana {
  nginx::site {
    "grafana-tls":
      source => 'puppet:///modules/tozt/nginx/grafana-tls.conf',
      require => Class['certbot'];
    "grafana":
      source => 'puppet:///modules/tozt/nginx/grafana.conf';
  }

  secret { "/media/persistent/grafana.htpasswd":
    source => "grafana",
    owner => 'http',
    require => [
      Class["tozt::persistent"],
      Package['nginx'],
    ];
  }
}
