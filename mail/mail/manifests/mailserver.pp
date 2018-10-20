class mail::mailserver {
  include mailserver

  file {
    "/usr/local/share/mailserver/docker-compose.yml":
      ensure => link,
      target => "/usr/local/share/mailserver/git/docker-compose.yml.dist",
      require => Class["mailserver"];
    "/usr/local/share/mailserver/.env":
      source => "puppet:///modules/mail/mailserver-env",
      require => Class["mailserver"];
  }

  service { "mailserver":
    ensure => running,
    require => [
      Class["mailserver"],
      Exec["systemctl daemon-reload"],
    ];
  }
}
