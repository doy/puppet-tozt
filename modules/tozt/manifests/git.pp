class tozt::git {
  include git::server
  include tozt::certbot
  include tozt::persistent

  package { "perl-io-socket-ssl":
    ensure => installed,
  }

  file {
    "/media/persistent/git/doy":
      ensure => directory,
      owner => 'doy',
      group => 'doy',
      require => [
        Class['tozt::persistent'],
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
    "/etc/cgitrc":
      source => "puppet:///modules/tozt/cgitrc";
    "/usr/local/share/git":
      ensure => directory;
    "/usr/local/share/git/post-receive":
      source => "puppet:///modules/tozt/post-receive",
      require => File['/usr/local/share/git'];
    "/usr/local/bin/new-git-repo":
      source => "puppet:///modules/tozt/new-git-repo",
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

  nginx::site {
    "git-tls":
      source => 'puppet:///modules/tozt/nginx/git-tls.conf',
      require => Class['certbot'];
    "git":
      source => 'puppet:///modules/tozt/nginx/git.conf';
  }
}
