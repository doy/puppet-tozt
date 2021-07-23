class podman::compose {
  include git
  include podman

  package { ['python-yaml', 'python-setuptools']:
    ensure => installed,
    install_options => ["--asdeps"];
  }

  package::makepkg { 'podman-compose-git':
    ensure => installed,
    require => [
      Package["podman"],
      Package["python-yaml"],
      Package["git"],
      Package["python-setuptools"],
    ];
  }
}
