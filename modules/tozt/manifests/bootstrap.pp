class bootstrap {
  file { '/usr/local/bin/tozt-puppet':
    source => 'puppet:///modules/bootstrap/tozt-puppet',
    mode => '0755';
  }
}
