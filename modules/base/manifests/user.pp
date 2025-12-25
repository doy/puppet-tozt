define base::user(
  $pwhash,
  $user=$name,
  $group=$user,
  $extra_groups=[],
  $homedir_mode='0700',
  $shell='/usr/bin/fish',
  $rust=false,
) {
  $home = base::home($user)

  group { $group:
    ensure => present;
  }

  user { $user:
    ensure => 'present',
    gid => $group,
    groups => $extra_groups,
    home => $home,
    shell => $shell,
    password => $pwhash,
    require => Group[$group];
  }

  file {
    $home:
      ensure => 'directory',
      owner => $user,
      group => $group,
      mode => $homedir_mode,
      require => [
        User[$user],
        Group[$group],
      ];
    "${home}/coding":
      ensure => 'directory',
      owner => $user,
      group => $group,
      mode => $homedir_mode,
      require => [
        User[$user],
        Group[$group],
        File[$home],
      ];
  }

  conf::user { $user:
  }

  if $user != 'root' {
    if $rust {
      rust::user { $user:
      }
    }
    sudo::user { $user:
    }
  }

  if $shell == '/usr/bin/fish' {
    include fish
    Class['fish'] -> User[$user]
  }
}
