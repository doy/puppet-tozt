class partofme::filesharing {
  include samba

  file { '/etc/samba/smb.conf':
    source => 'puppet:///modules/partofme/smb.conf',
    require => Package['samba'],
    before => [
      Service['smb'],
      Service['nmb'],
    ];
  }
}
