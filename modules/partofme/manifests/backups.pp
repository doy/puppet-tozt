class partofme::backups {
  syncthing::user { $::default_user:
  }

  include restic::server
  file {
    "/media/persistent/restic/.ssh/authorized_keys":
      source => 'puppet:///modules/partofme/restic_authorized_keys',
      owner => 'restic',
      group => 'restic',
      mode => '0600',
      require => Class['restic::server'];
  }

  class { 'restic::local':
  }

  package { 'rclone':
    ensure => installed;
  }

  $b2_account = secret::value('b2-account')
  $b2_key = secret::value('b2-key')
  $b2_password = secret::value('b2-password')
  $b2_salt = secret::value('b2-salt')
  file { '/etc/rclone.conf':
    content => template('partofme/rclone.conf');
  }

  cron::job { 'rclone':
    frequency => "daily",
    source => 'puppet:///modules/partofme/rclone-cron',
    require => [
      Package['rclone'],
      File['/etc/rclone.conf'],
    ];
  }
}
