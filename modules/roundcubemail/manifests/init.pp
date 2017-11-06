class roundcubemail {
  include systemd

  package { ['roundcubemail', 'spawn-fcgi']:
    ensure => installed;
  }

  file { '/etc/systemd/system/roundcubemail.service':
    source => 'puppet:///modules/roundcubemail/roundcubemail.service',
    require => [
      Package['roundcubemail'],
      Package['spawn-fcgi'],
    ],
    notify => Exec['systemctl daemon-reload'];
  }

  service { 'roundcubemail':
    ensure => running,
    require => [
      File['/etc/systemd/system/roundcubemail.service'],
      Exec['systemctl daemon-reload'],
    ];
  }
}
