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
      "neomutt",
      "ncdu",
      "strace",
      "the_silver_searcher",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
