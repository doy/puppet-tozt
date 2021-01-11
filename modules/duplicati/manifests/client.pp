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
      ensure => directory,
      recurse => true,
      purge => true;
  }

  # patch branch for now until this lands
  $duplicati_client_sha = '0b5e29d43d0b25cd25c2f3877ea377a2d858c296'
  exec { 'clone duplicati-client':
    # command => '/usr/bin/git clone git://github.com/Pectojin/duplicati-client',
    command => '/usr/bin/git clone git://github.com/doy/duplicati-client',
    cwd => '/opt',
    creates => '/opt/duplicati-client/.git';
  }

  exec { 'checkout duplicati-client':
    provider => shell,
    command => "/usr/bin/git fetch && /usr/bin/git checkout $duplicati_client_sha",
    unless => "test \"\$(git rev-parse @)\" = \"$duplicati_client_sha\"",
    cwd => '/opt/duplicati-client',
    require => Exec['clone duplicati-client'];
  }

  exec { 'duplicati-client login':
    command => '/usr/local/bin/duplicati-client login',
    creates => '/root/.config/duplicati-client/config.yml',
    tries => 3,
    try_sleep => 10,
    require => [
      File['/usr/local/bin/duplicati-client'],
      Exec['checkout duplicati-client'],
      Service['duplicati'],
    ]
  }
}
