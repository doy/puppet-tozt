define tozt::user(
  $pwhash,
  $user=$name,
  $group=$user,
  $home=undef,
  $extra_groups=[],
  $shell='/usr/bin/zsh',
) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  group { $group:
    ensure => present;
  }

  user { $user:
    ensure => 'present',
    gid => $group,
    groups => $extra_groups,
    home => $_home,
    shell => $shell,
    password => $pwhash,
    require => Group[$group];
  }

  conf { $user:
  }

  if $user != 'root' {
    sudo::user { $user:
    }
  }

  if $shell == '/usr/bin/zsh' {
    Package['zsh'] -> User[$user]
  }
}
