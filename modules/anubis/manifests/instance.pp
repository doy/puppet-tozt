define anubis::instance($port, $metrics_port, $target) {
  include anubis

  file {
    "/etc/anubis/${name}.env":
      content => template("anubis/env"),
      require => Package["anubis"];
    "/etc/anubis/${name}.botPolicies.yaml":
      ensure => link,
      target => "/usr/share/doc/anubis/data/botPolicies.yaml",
      require => Package["anubis"];
  }

  service { "anubis@${name}":
    ensure => running,
    enable => true,
    subscribe => [
      Package["anubis"],
      File["/etc/anubis/${name}.env"],
      File["/etc/anubis/${name}.botPolicies.yaml"],
    ];
  }
}
