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
      source => "puppet:///modules/base/hosts";
  }

  exec { "regen locale data":
    command => "/usr/bin/locale-gen",
    refreshonly => true;
  }
}
