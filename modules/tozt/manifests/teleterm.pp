class tozt::teleterm {
  include tozt::persistent

  $version = "0.1.0"
  $client_id = secret::value('teleterm_client_id')
  $client_secret = secret::value('teleterm_client_secret')

  class { 'teleterm':
    source => "/media/persistent/releases/doy/teleterm/arch/teleterm-${version}-1-x86_64.pkg.tar.xz",
    require => File['/media/persistent/releases'];
  }

  file {
    "/etc/teleterm":
      ensure => directory;
    "/etc/teleterm/config.toml":
      content => template("tozt/teleterm.toml"),
      require => File["/etc/teleterm"],
      before => Service["teleterm"];
  }
}
