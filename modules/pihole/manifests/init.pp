class pihole($dir) {
  include podman

  $webpassword = secret::value("pihole")

  file {
    $dir:
      ensure => directory;
    "${dir}/etc-pihole":
      ensure => directory,
      require => File[$dir];
    "${dir}/etc-pihole/pihole-FTL.conf":
      source => "puppet:///modules/pihole/pihole-FTL.conf",
      require => File["${dir}/etc-pihole"];
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
      Class["podman"],
      File["${dir}/etc-pihole"],
      File["${dir}/etc-dnsmasq.d"],
      File["/var/log/pihole.log"],
    ],
    subscribe => Systemd::Service["pihole"];
  }
}
