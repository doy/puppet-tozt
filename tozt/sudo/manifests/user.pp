define sudo::user($user=$name) {
  include sudo

  file { "/var/db/sudo/lectured/$user":
    ensure => 'present';
  }
}
