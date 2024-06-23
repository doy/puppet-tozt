class restic::remote($host = 'partofme', $extra_paths = []) {
  include restic
  
  secret { "/etc/ssh/restic":
    source => 'restic_ssh_key';
  }

  file { "/etc/ssh/ssh_config.d/restic.conf":
    content => template("restic/ssh");
  }

  $rest_password = secret::value('restic-rest')

  class { 'restic::instance':
    repo => "rest:http://partofme:8000/${facts['networking']['hostname']}",
    extra_paths => $extra_paths,
    extra_env => [
      "RESTIC_REST_USERNAME=${facts['networking']['hostname']}",
      "RESTIC_REST_PASSWORD=${rest_password}"
    ],
    require => [
      File["/etc/ssh/restic"],
      File["/etc/ssh/ssh_config.d/restic.conf"],
    ];
  }
}
