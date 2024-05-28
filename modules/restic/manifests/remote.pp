class restic::remote($host = 'partofme', $extra_paths = []) {
  include restic
  
  secret { "/etc/ssh/restic":
    source => 'restic_ssh_key';
  }

  file { "/etc/ssh/ssh_config.d/restic.conf":
    content => template("restic/ssh");
  }

  class { 'restic::instance':
    repo => "sftp:restic@restic:/media/persistent/restic/${facts['networking']['hostname']}",
    extra_paths => $extra_paths,
    require => [
      File["/etc/restic/restic_ssh_key"],
      File["/etc/ssh/ssh_config.d/restic.conf"],
    ];
  }
}
