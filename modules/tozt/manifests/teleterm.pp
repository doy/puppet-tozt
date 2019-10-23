class tozt::teleterm {
  include teleterm

  $client_id = secret::value('teleterm_client_id')
  $client_secret = secret::value('teleterm_client_secret')

  file {
    "/etc/teleterm":
      ensure => directory;
    "/etc/teleterm/config.toml":
      contents => template("tozt/teleterm.toml"),
      require => File["/etc/teleterm"],
      before => Service["teleterm"];
  }
}
