define tozt::user(
  $pwhash,
  $user=$name,
  $group=$user,
  $home=undef,
  $extra_groups=[],
  $homedir_mode='0700',
  $shell='/usr/bin/zsh',
) {
  $_home = $home ? {
    undef => $user ? {
      'root' => '/root',
      default => "/home/$user",
    },
    default => $home,
  }

  include tozt::persistent

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

  file {
    $_home:
      ensure => 'directory',
      owner => $user,
      group => $group,
      mode => $homedir_mode,
      require => [
        User[$user],
        Group[$group],
      ];
    "${_home}/coding":
      ensure => 'directory',
      owner => $user,
      group => $group,
      mode => $homedir_mode,
      require => [
        User[$user],
        Group[$group],
        File[$_home],
      ];
    "/media/persistent/cargo/${user}":
      ensure => 'directory',
      owner => $user,
      group => $group,
      mode => $homedir_mode,
      require => [
        User[$user],
        Group[$group],
        Class["tozt::persistent"],
      ];
    "/media/persistent/rustup/${user}":
      ensure => 'directory',
      owner => $user,
      group => $group,
      mode => $homedir_mode,
      require => [
        User[$user],
        Group[$group],
        Class["tozt::persistent"],
      ];
    "${_home}/.cargo":
      ensure => link,
      target => "/media/persistent/cargo/${user}",
      owner => $user,
      group => $group,
      require => [
        User[$user],
        Group[$group],
        File["${_home}"],
      ];
    "${_home}/.rustup":
      ensure => link,
      target => "/media/persistent/rustup/${user}",
      owner => $user,
      group => $group,
      require => [
        User[$user],
        Group[$group],
        File["${_home}"],
      ];
  }

  rust::user { $user:
  }
  conf::user { $user:
  }

  if $user != 'root' {
    sudo::user { $user:
    }
  }

  if $shell == '/usr/bin/zsh' {
    include zsh
    Class['zsh'] -> User[$user]
  }
}
