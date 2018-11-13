class base::users($default_user, $persistent_data) {
  base::user { 'root':
    pwhash => secret::value('passwd/root'),
    persistent_data => $persistent_data;
  }

  base::user { $default_user:
    pwhash => secret::value("passwd/$default_user"),
    extra_groups => ['wheel'],
    homedir_mode => '0701',
    persistent_data => $persistent_data;
  }
}
