class base::users {
  base::user { 'root':
    pwhash => secret::value('passwd/root');
  }

  base::user { $default_user:
    pwhash => secret::value("passwd/$default_user"),
    extra_groups => ['wheel'],
    homedir_mode => '0701',
    before -> Package::Makepkg<| build_user == $default_user |>;
  }
}
