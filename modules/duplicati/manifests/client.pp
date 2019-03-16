class duplicati::client {
  package { ['python-yaml', 'python-dateutil', 'python-requests']:
    ensure => installed;
  }

  file {
    '/usr/local/bin/duplicati-client':
      ensure => link,
      target => '/opt/duplicati-client/duplicati_client.py',
      require => Exec['checkout duplicati-client'];
    '/etc/duplicati':
      ensure => directory;
  }

  $duplicati_client_sha = '4f8b46a6f00dc719d84278e66b5a17939fb4a3d6'
  exec { 'clone duplicati-client':
    command => '/usr/bin/git clone git://github.com/Pectojin/duplicati-client',
    cwd => '/opt',
    creates => '/opt/duplicati-client/.git';
  }

  exec { 'checkout duplicati-client':
    provider => shell,
    command => "/usr/bin/git checkout $duplicati_client_sha",
    unless => "test \"\$(git rev-parse @)\" = \"$duplicati_client_sha\"",
    cwd => '/opt/duplicati-client',
    require => Exec['clone duplicati-client'];
  }

  exec { 'duplicati-client login':
    command => '/usr/local/bin/duplicati-client login',
    creates => '/root/.config/duplicati-client/config.yml',
    require => [
      File['/usr/local/bin/duplicati-client'],
      Exec['checkout duplicati-client'],
      Service['duplicati'],
    ]
  }
}
