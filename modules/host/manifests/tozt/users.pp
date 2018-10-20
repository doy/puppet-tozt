class host::tozt::users {
  host::tozt::user { 'root':
    pwhash => '$6$cqlzoze/Mq3$bHGFqjPF6wBRLcI0VWuQa9cg8c1DfGWL21QdA9KUuDqhtnCfjyaKryu.ACxP9umzuYsWpikegZN6wbTU2JX6V1';
  }

  host::tozt::user { 'doy':
    pwhash => '$6$Q6Y/nmt/QZbU$6D692oUPiFvnQEwoPtL7l83l/KaY/czy9/KI9.GnEEOslQumU39qteDDp.0i9E7nSDodWGOmPgfAsoYJBYrta1',
    extra_groups => ['wheel'],
    homedir_mode => '0701';
  }
}
