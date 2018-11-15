class base($default_user, $persistent_data=undef) {
  contain base::bootstrap
  contain base::operatingsystem
  contain base::services
  contain base::tools
  contain base::vpn

  class { 'base::users':
    default_user => $default_user,
    persistent_data => $persistent_data;
  }
}
