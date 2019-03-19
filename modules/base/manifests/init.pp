class base($extra_script="") {
  class { 'base::bootstrap':
    extra_script => $extra_script;
  }
  contain base::operatingsystem
  contain base::services
  contain base::tools
  contain base::users
  contain base::vpn
}
