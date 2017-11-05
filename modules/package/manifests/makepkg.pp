define package::makepkg($extra_options=[]) {
  $extra_cmdline = join($extra_options, ' ')

  exec { "install $name":
    command => "
      mkdir -p /tmp/makepkg
      cd /tmp/makepkg
      rm -rf '$name'
      su doy -c 'git clone https://aur.archlinux.org/$name.git'
      cd '$name'
      su doy -c makepkg
      pacman -U --noconfirm --needed $extra_cmdline $name-*.pkg.tar.xz
    ",
    unless => "pacman -Q $name > /dev/null 2>&1",
    require => [
      Tozt::User["doy"],
      Package["git"],
      Package["pkg-config"],
    ];
  }
}
