class pihole($dir, $server_ip) {
  include podman

  file {
    $dir:
      ensure => directory;
    "${dir}/etc-pihole":
      ensure => directory,
      require => File[$dir];
    "${dir}/etc-dnsmasq.d":
      ensure => directory,
      require => File[$dir];
    "${dir}/var-log":
      ensure => directory,
      require => File[$dir];
    "${dir}/var-log/pihole.log":
      ensure => file,
      require => File["${dir}/var-log"];
  }

  systemd::service { "pihole":
    content => template("pihole/pihole.service"),
  }

  service { "pihole":
    ensure => "running",
    enable => true,
    require => [
      Package["podman"],
      File["${dir}/etc-pihole"],
      File["${dir}/etc-dnsmasq.d"],
      File["${dir}/var-log/pihole.log"],
    ],
    subscribe => Systemd::Service["pihole"];
  }
}
