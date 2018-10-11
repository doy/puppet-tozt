class tozt::tools {
  include mail::sender
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
