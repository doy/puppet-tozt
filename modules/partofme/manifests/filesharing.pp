class partofme::filesharing {
  include gonic
  include samba

  file { '/etc/samba/smb.conf':
    source => 'puppet:///modules/partofme/smb.conf',
    require => Package['samba'],
    notify => [
      Service['smb'],
      Service['nmb'],
    ];
  }
}
