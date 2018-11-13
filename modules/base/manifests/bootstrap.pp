class base::bootstrap {
  package {
    [
      "puppet",
      "rsync",
    ]:
    ensure => installed,
  }

  file { '/usr/local/bin/puppet-tozt':
    source => 'puppet:///modules/base/puppet-tozt',
    mode => '0755';
  }
}
