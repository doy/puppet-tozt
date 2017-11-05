define package::yaourt($ensure, $asdeps=false) {
  if $asdeps {
    $_asdeps = " --asdeps"
  }
  else {
    $_asdeps = ""
  }

  case $ensure {
    'installed': {
      exec { "/usr/bin/yaourt --noconfirm --needed$_asdeps -S $name":
        unless => "/usr/bin/pacman -Q $name > /dev/null 2>&1",
        require => Package::Makepkg["yaourt"];
      }
    }
    'absent': {
      exec { "/usr/bin/yaourt --noconfirm -Rsn $name":
        onlyif => "/usr/bin/pacman -Q $name > /dev/null 2>&1",
        require => Package::Makepkg["yaourt"];
      }
    }
    default: {
      fail("only 'installed' and 'absent' are supported for 'ensure'")
    }
  }
}
