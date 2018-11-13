class tozt::certbot {
  include tozt::persistent

  class { "certbot":
    config_dir => "/media/persistent/certbot",
    require => Class["tozt::persistent"],
  }
}
