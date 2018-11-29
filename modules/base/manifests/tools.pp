class base::tools {
  include mail::sender
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
      "mutt",
      "ncdu",
      "strace",
      "the_silver_searcher",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
