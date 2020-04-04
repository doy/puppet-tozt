class tozt::bitwarden {
  include tozt::persistent

  class { "bitwarden::server":
    data_dir => "/media/persistent/bitwarden";
  }
}
