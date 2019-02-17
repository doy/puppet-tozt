class base::tools {
  include yaourt

  package {
    [
      "bc",
      "exa",
      "fzf",
      "htop",
      "iftop",
      "iotop",
      "lsof",
      # remove after https://bugs.archlinux.org/task/61603 is fixed
      "libidn",
      "neomutt",
      "ncdu",
      "strace",
      "the_silver_searcher",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
