class base::users {
  base::user { 'root':
    pwhash => secret::value('passwd_root');
  }

  base::user { $::default_user:
    pwhash => secret::value("passwd_$default_user"),
    extra_groups => ['wheel', 'video', 'audio'],
    homedir_mode => '0701';
  }

  Base::User[$::default_user] -> Package::Makepkg<| build_user == $::default_user |>
}
