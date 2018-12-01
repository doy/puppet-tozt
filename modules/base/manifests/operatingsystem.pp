class base::operatingsystem {
  file {
    "/etc/locale.gen":
      content => "en_US.UTF-8 UTF-8\n",
      notify => Exec["regen locale data"];
    "/etc/locale.conf":
      content => "LANG=en_US.UTF-8\n",
      require => [
        File["/etc/locale.gen"],
        Exec["regen locale data"],
      ];
    "/etc/hosts":
      content => template('base/hosts');
    '/etc/yaourtrc':
      source => 'puppet:///modules/base/yaourtrc';
  }

  exec { "regen locale data":
    command => "/usr/bin/locale-gen",
    refreshonly => true;
  }
}
