class pihole($dir) {
  include podman

  $webpassword = secret::value("pihole")

  file {
    $dir:
      ensure => directory;
    "${dir}/etc-pihole":
      ensure => directory,
      require => File[$dir];
    "${dir}/etc-dnsmasq.d":
      ensure => directory,
      require => File[$dir];
    "/var/log/pihole.log":
      ensure => file;
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
