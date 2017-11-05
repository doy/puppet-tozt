define package::yaourt($asdeps=false) {
  if $asdeps {
    $_asdeps = " --asdeps"
  }
  else {
    $_asdeps = ""
  }

  exec { "/usr/bin/yaourt --noconfirm --needed$asdeps $name":
    unless => "pacman -Q $name > /dev/null 2>&1",
    require => Package::Makepkg["yaourt"];
  }
}
