define package::makepkg($asdeps=false) {
  if $asdeps {
    $extra_cmdline = " --asdeps"
  }
  else {
    $extra_cmdline = ""
  }

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
    path => "/usr/bin",
    require => [
      Tozt::User["doy"],
      Package["git"],
      Package["pkg-config"],
    ];
  }
}
