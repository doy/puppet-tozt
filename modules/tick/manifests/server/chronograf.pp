class tick::server::chronograf {
  package::makepkg { 'chronograf-bin':
    ensure => installed;
  }

  file {
    "/etc/default/chronograf":
      source => "puppet:///modules/tick/chronograf",
      require => Package::Makepkg['chronograf-bin'],
      notify => Service['chronograf'];
    "/media/persistent/chronograf":
      ensure => directory,
      owner => "chronograf",
      group => "chronograf",
      require => Package::Makepkg['chronograf-bin'];
  }

  service { 'chronograf':
    ensure => running,
    enable => true,
    require => Package::Makepkg['chronograf-bin'];
  }
}
