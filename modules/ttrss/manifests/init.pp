class ttrss {
  package {
    [
      "tt-rss",
      "php-pgsql",
      "php-fpm",
    ]:
      ensure => absent;
  }

  file {
    "/etc/webapps/tt-rss/config.php":
      ensure => absent;
    "/etc/pacman.d/hooks":
      ensure => directory;
    "/etc/pacman.d/hooks/tt-rss.hook":
      ensure => absent;
  }

  service { "tt-rss":
    ensure => stopped,
    enable => false;
  }

  service { "php-fpm":
    ensure => stopped,
    enable => false;
  }
}
