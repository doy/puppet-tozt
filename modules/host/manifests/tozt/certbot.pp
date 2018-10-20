class host::tozt::certbot {
  include host::tozt::persistent

  class { "certbot":
    config_dir => "/media/persistent/certbot",
    require => Class["host::tozt::persistent"],
  }
}
