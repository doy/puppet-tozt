class partofme::git {
  include git::server
  include partofme::persistent

  package { "perl-io-socket-ssl":
    ensure => installed,
  }

  file {
    "/media/persistent/git/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        File['/media/persistent/git'],
        Class['partofme::persistent'],
        User['doy'],
        Group['doy'],
      ];
    "/home/doy/git":
      ensure => link,
      target => "/media/persistent/git/doy",
      owner => 'doy',
      group => 'doy',
      require => [
        User['doy'],
        Group['doy'],
        File["/home/doy"],
      ];
    "/media/persistent/releases/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        File['/media/persistent/releases'],
        Class['partofme::persistent'],
        User['doy'],
        Group['doy'],
      ];
    "/home/doy/releases":
      ensure => link,
      target => "/media/persistent/releases/doy",
      owner => 'doy',
      group => 'doy',
      require => [
        User['doy'],
        Group['doy'],
        File["/home/doy"],
      ];
    "/etc/cgitrc":
      source => "puppet:///modules/partofme/cgitrc";
    "/usr/local/share/git":
      ensure => directory;
    "/usr/local/share/git/post-receive":
      source => "puppet:///modules/partofme/post-receive",
      require => File['/usr/local/share/git'];
    "/usr/local/bin/new-git-repo":
      source => "puppet:///modules/partofme/new-git-repo",
      mode => '0755',
      require => [
        Package['perl-io-socket-ssl'],
        File['/usr/local/share/git/post-receive'],
      ];
  }

  secret { "/home/doy/.github":
    source => 'github',
    owner => 'doy',
    group => 'doy',
    require => [
      User['doy'],
      Group['doy'],
      File["/home/doy"],
    ];
  }

  anubis::instance { "git":
    port => "29876",
    metrics_port => "39876",
    target => "http://localhost:8083";
  }

  nginx::site {
    "git":
      source => 'puppet:///modules/partofme/nginx/git.conf';
  }
}
