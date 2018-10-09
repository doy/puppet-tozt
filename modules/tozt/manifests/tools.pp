class tozt::tools {
  include yaourt

  package {
    [
      "bc",
      "exa",
      "fzf",
      "htop",
      "lsof",
      "ncdu",
      "strace",
      "the_silver_searcher",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
