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
    mode => '0600',
  }
  secret { "${_home}/.ssh/id_rsa.pub":
    source => "ssh/${user}/pubkey",
    owner => $user,
    group => $group,
    mode => '0600',
  }
}
