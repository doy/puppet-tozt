class pihole($dir) {
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
      content => "",
      require => File["${dir}/var-log"];
  }

  systemd::service { "pihole":
    source => "puppet:///modules/pihole/pihole.service";
  }

  service { "pihole":
    ensure => "running",
    enable => true,
    subscribe => Systemd::Service["pihole"];
  }
}
