class samba {
  package { 'samba':
    ensure => installed;
  }

  service { ['smb', 'nmb']:
    ensure => running,
    enable => true,
    require => Package['samba'];
  }
}
