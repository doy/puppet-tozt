class partofme::bitwarden {
  include partofme::persistent

  class { "bitwarden::server":
    data_dir => "/media/persistent/bitwarden";
  }
}
