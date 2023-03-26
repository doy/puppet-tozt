class podman {
  package { ["podman", "cni-plugins"]:
    ensure => installed;
  }

  cron::job { "podman-prune":
    frequency => "daily",
    source => 'puppet:///modules/podman/podman-prune';
  }
}
