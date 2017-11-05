class tozt::bootstrap {
  file { '/usr/local/bin/tozt-puppet':
    source => 'puppet:///modules/tozt/tozt-puppet',
    mode => '0755';
  }
}
