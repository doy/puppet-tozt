class base::bootstrap($extra_script="") {
  package {
    [
      "puppet",
      "rsync",
    ]:
    ensure => installed,
  }

  file {
    '/usr/local/bin/puppet-tozt':
      source => 'puppet:///modules/base/puppet-tozt',
      mode => '0755';
    '/usr/local/bin/update':
      content => template('base/update'),
      mode => '0755';
  }
}
