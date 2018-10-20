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
    "/usr/local/share/mailserver/config":
      ensure => directory,
      require => Class["mailserver"];
    # XXX regen this with real user/pass
    "/usr/local/share/mailserver/config/postfix-accounts.cf":
      source => "puppet:///modules/mail/postfix-accounts.cf",
      require => Class["mailserver"];
  }

  exec { "create initial mailserver user":
    command => "/usr/local/bin/mailserver-setup email add doy@newmail.tozt.net",
    require => Class["mailserver"];
  }

  service { "mailserver":
    ensure => running,
    require => [
      Class["mailserver"],
      Exec["systemctl daemon-reload"],
      File["/usr/local/share/mailserver/config/postfix-accounts.cf"],
    ];
  }
}
