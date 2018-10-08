define package::makepkg($ensure, $asdeps=false) {
  if $asdeps {
    $extra_cmdline = " --asdeps"
  }
  else {
    $extra_cmdline = ""
  }

  case $ensure {
    'installed': {
      exec { "makepkg install $name":
        provider => "shell",
        command => "
          cd /tmp
          rm -rf 'makepkg-$name'
          su doy -c 'git clone https://aur.archlinux.org/$name.git makepkg-$name'
          cd 'makepkg-$name'
          su doy -c makepkg
          pacman -U --noconfirm --needed $extra_cmdline $name-*.pkg.tar.xz
        ",
        unless => "pacman -Q $name > /dev/null 2>&1",
        path => "/usr/bin",
        require => [
          Tozt::User["doy"],
          Package["git"],
          Package["pkgconf"],
        ];
      }
    }
    'absent': {
      exec { "makepkg uninstall $name":
        provider => "shell",
        command => "pacman --noconfirm -Rsn $name",
        onlyif => "pacman -Q $name > /dev/null 2>&1",
        path => "/usr/bin";
      }
    }
  }
}
