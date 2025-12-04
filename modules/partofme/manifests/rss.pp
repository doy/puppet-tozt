class partofme::rss {
  include partofme::persistent

  $data_dir = "/media/persistent/freshrss";

  class { "freshrss":
    data_dir => "$data_dir",
    require => Class["partofme::persistent"];
  }
}
