define ssh::user($user=$name, $home=undef) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  secret { "${_home}/.ssh/id_rsa":
    source => "ssh/${user}/privkey",
  }
  secret { "${_home}/.ssh/id_rsa.pub":
    source => "ssh/${user}/pubkey",
  }
}
