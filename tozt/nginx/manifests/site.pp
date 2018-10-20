define nginx::site($content=undef, $source=undef, $enabled=true) {
  include nginx

  file { "/etc/nginx/sites-available/$name":
    source => $source,
    content => $content;
  }

  if $enabled {
    file { "/etc/nginx/sites-enabled/$name":
      ensure => link,
      target => "../sites-available/$name";
    }
  }
  else {
    file { "/etc/nginx/sites-enabled/$name":
      ensure => absent;
    }
  }
}
