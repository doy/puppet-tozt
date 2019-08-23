class postgres {
  include systemd

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
    "/etc/systemd/system/postgresql.service.d":
      ensure => directory;
    "/etc/systemd/system/postgresql.service.d/override.conf":
      content => template('postgres/postgres-service'),
      notify => Exec["/usr/bin/systemctl daemon-reload"],
      require => File["/etc/systemd/system/postgresql.service.d"];
  }

  exec { "fixup db path permissions":
    command => "chown -R postgres:postgres ${dbpath}",
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
    require => [
      Package["postgresql"],
      Exec["initialize db path"],
    ];
  }
}
