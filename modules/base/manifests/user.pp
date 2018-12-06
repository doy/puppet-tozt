define base::user(
  $pwhash,
  $user=$name,
  $group=$user,
  $extra_groups=[],
  $homedir_mode='0700',
  $shell='/usr/bin/zsh',
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
    if $persistent_data != undef { # lint:ignore:variable_scope
      file {
        "$persistent_data/cargo":
          ensure => 'directory';
        "$persistent_data/rustup":
          ensure => 'directory';
        "$persistent_data/cargo/${user}":
          ensure => 'directory',
          owner => $user,
          group => $group,
          mode => $homedir_mode,
          require => [
            User[$user],
            Group[$group],
            File["$persistent_data/cargo"],
          ];
        "$persistent_data/rustup/${user}":
          ensure => 'directory',
          owner => $user,
          group => $group,
          mode => $homedir_mode,
          require => [
            User[$user],
            Group[$group],
            File["$persistent_data/rustup"],
          ];
        "${home}/.cargo":
          ensure => link,
          target => "$persistent_data/cargo/${user}",
          owner => $user,
          group => $group,
          require => [
            User[$user],
            Group[$group],
            File[$home],
          ];
        "${home}/.rustup":
          ensure => link,
          target => "$persistent_data/rustup/${user}",
          owner => $user,
          group => $group,
          require => [
            User[$user],
            Group[$group],
            File[$home],
          ];
      }

      File["${home}/.rustup"] -> Rust::User[$user]
      File["$persistent_data/rustup/${user}"] -> Rust::User[$user]

      File["${home}/.cargo"] -> Package::Cargo<| |>
      File["$persistent_data/cargo/${user}"] -> Package::Cargo<| |>
    }

    rust::user { $user:
    }
    sudo::user { $user:
    }
  }

  if $shell == '/usr/bin/zsh' {
    include zsh
    Class['zsh'] -> User[$user]
  }
}
