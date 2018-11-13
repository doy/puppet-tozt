class tozt::users {
  tozt::user { 'root':
    pwhash => secret::value('passwd/root');
  }

  tozt::user { 'doy':
    pwhash => secret::value('passwd/doy'),
    extra_groups => ['wheel'],
    homedir_mode => '0701';
  }
}
