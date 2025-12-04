class partofme::rss {
  include partofme::persistent

  $data_dir = "/media/persistent/freshrss";

  file {
    "$data_dir":
      ensure => directory;
    "$data_dir/.htaccess":
      source => 'puppet:///modules/partofme/freshrss-htaccess',
      require => [
        File["/media/persistent"],
        File["$data_dir"],
      ];
  }

  secret { "$data_dir/.htpasswd":
    source => "rss",
    require => [
      File["/media/persistent"],
      File["$data_dir"],
    ];
  }

  class { "freshrss":
    data_dir => "$data_dir",
    require => File["/media/persistent"];
  }
}
