class podman {
  package { ["podman", "cni-plugins"]:
    ensure => installed;
  }
}
