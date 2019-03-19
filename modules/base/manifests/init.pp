class base {
  class { 'base::bootstrap':
    extra_script => "
      (cd /media/persistent && sudo docker-compose pull -q)
    ",
  }
  contain base::operatingsystem
  contain base::services
  contain base::tools
  contain base::users
  contain base::vpn
}
