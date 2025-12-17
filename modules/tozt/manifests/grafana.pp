class tozt::grafana {
  nginx::vhost { "grafana":
    content => file('tozt/nginx/grafana'),
    prefix => file('nginx/websockets');
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
