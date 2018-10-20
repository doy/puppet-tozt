define ssh::user($user=$name, $group=$user, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  secret { "${_home}/.ssh/id_rsa":
    source => "ssh/${user}/privkey",
    owner => $user,
    group => $group,
  }
  secret { "${_home}/.ssh/id_rsa.pub":
    source => "ssh/${user}/pubkey",
    owner => $user,
    group => $group,
  }
}
