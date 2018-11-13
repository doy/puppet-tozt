class base($default_user, $persistent_data) {
  contain base::bootstrap
  contain base::operatingsystem
  contain base::services
  contain base::tools

  class { 'base::users':
    default_user => $default_user,
    persistent_data => $persistent_data;
  }
  class { 'base::makepkg':
    default_user => $default_user;
  }
}
