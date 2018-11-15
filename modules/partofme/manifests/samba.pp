class partofme::samba {
  include samba

  file { '/etc/samba/smb.conf':
    source => 'puppet:///modules/partofme/smb.conf',
    before => Class['samba'];
  }
}
