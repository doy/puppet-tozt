class samba {
  package { 'samba':
    ensure => installed;
  }

  service { ['smb', 'nmb']:
    enable => true,
    ensure => running,
    require => Package['samba'];
  }
}
