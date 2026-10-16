class calendar {
  exec { "clone calendar":
    command => "/usr/bin/git clone https://github.com/doy/calendar",
    user => "doy",
    cwd => "/home/doy/coding",
    creates => "/home/doy/coding/calendar",
    require => [
      Class["git"],
      File["/home/doy/coding"],
    ],
  }

  systemd::service { "calendar":
    source => 'puppet:///modules/calendar/calendar.service',
  }

  service { "calendar":
    ensure => "running",
    enable => true,
    require => [
      Exec["clone calendar"],
      Rust::User["doy"],
    ],
    subscribe => Systemd::Service["calendar"];
  }
}
