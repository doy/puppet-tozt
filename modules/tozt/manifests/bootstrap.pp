class tozt::bootstrap {
  package { "puppet":
    ensure => installed,
  }

  file { '/usr/local/bin/puppet-tozt':
    source => 'puppet:///modules/tozt/puppet-tozt',
    mode => '0755';
  }
}
