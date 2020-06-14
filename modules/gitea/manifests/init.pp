class gitea {
  include systemd

  package { "gitea":
    ensure => installed;
  }

  user { "gitea":
    home => '/media/persistent/gitea',
    require => Package["gitea"];
  }

  service { "gitea":
    ensure => running,
    enable => true,
    require => [
      Package['gitea'],
      File['/etc/systemd/system/gitea.service.d/override.conf'],
      Exec["/usr/bin/systemctl daemon-reload"],
      File['/media/persistent/gitea/custom/conf/app.ini'],
    ];
  }

  $secret_key = secret::value('gitea_secret_key')
  $jwt_secret = secret::value('gitea_jwt_secret')

  file {
    '/media/persistent/gitea':
      ensure => directory,
      owner => 'gitea',
      group => 'gitea';
    '/media/persistent/gitea/custom':
      ensure => directory,
      owner => 'gitea',
      group => 'gitea',
      require => [
        Package['gitea'],
        File['/media/persistent/gitea'],
      ];
    '/media/persistent/gitea/custom/conf':
      ensure => directory,
      owner => 'gitea',
      group => 'gitea',
      require => [
        Package['gitea'],
        File['/media/persistent/gitea/custom'],
      ];
    '/media/persistent/gitea/custom/conf/app.ini':
      content => template('gitea/app.ini'),
      owner => 'gitea',
      group => 'gitea',
      require => File['/media/persistent/gitea/custom/conf'];
    '/etc/systemd/system/gitea.service.d':
      ensure => directory;
    '/etc/systemd/system/gitea.service.d/override.conf':
      source => 'puppet:///modules/gitea/override.conf',
      notify => Exec["/usr/bin/systemctl daemon-reload"],
      require => File["/etc/systemd/system/gitea.service.d"];
  }
}