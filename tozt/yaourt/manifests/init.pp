class yaourt {
  package {
    [
      "yajl"
    ]:
    ensure => 'installed',
    install_options => ["--asdeps"];
  }

  package::makepkg { 'package-query':
    ensure => installed,
    asdeps => true,
    require => Package['yajl'];
  }

  package::makepkg { 'yaourt':
    ensure => installed,
    require => Package::Makepkg['package-query'];
  }
}
