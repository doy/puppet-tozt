class postgres {
  $dbpath = "${persistent_data}/postgres" # lint:ignore:variable_scope

  package { "postgresql":
      ensure => installed,
      notify => Exec["fixup db path permissions"];
  }

  file {
    $dbpath:
      ensure => directory,
      owner => 'postgres',
      group => 'postgres',
      require => Package["postgresql"];
    "$dbpath/data":
      ensure => directory,
      owner => 'postgres',
      group => 'postgres',
      require => [
        Package["postgresql"],
        File[$dbpath],
      ];
  }

  systemd::override { "postgresql":
    content => template('postgres/postgres-service');
  }

  exec { "fixup db path permissions":
    command => "/usr/bin/chown -R postgres:postgres ${dbpath}",
    refreshonly => true,
    require => [
      Package['postgresql'],
      File[$dbpath],
    ],
    before => Service['postgresql'];
  }

  exec { "initialize db path":
    command => "/usr/bin/initdb -D $dbpath/data",
    user => 'postgres',
    creates => "$dbpath/data/PG_VERSION",
    require => [
      File["$dbpath/data"],
      Package["postgresql"],
    ];
  }

  service { "postgresql":
    ensure => running,
    enable => true,
    subscribe => Systemd::Override['postgresql'],
    require => [
      Package["postgresql"],
      Exec["initialize db path"],
    ];
  }
}
