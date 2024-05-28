class restic::remote($host = 'partofme', $extra_paths = []) {
  include restic
  
  secret { "/etc/restic/restic_ssh_key":
    source => 'restic_ssh_key',
    require => File["/etc/restic"];
  }

  sshd::configsection { 'restic':
    source => 'puppet:///modules/restic/sshd_config';
  }

  class { 'restic::instance':
    repo => "sftp:restic@${host}:/media/persistent/restic/${facts['networking']['hostname']}",
    extra_paths => $extra_paths,
    require => [
      File["/etc/restic/restic_ssh_key"],
    ];
  }
}
