class partofme::rss {
  include partofme::persistent

  class { "freshrss":
    data_dir => "/media/persistent/freshrss",
    require => File["/media/persistent"];
  }
}
