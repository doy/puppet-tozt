class base::tools {
  include yay

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
      "ripgrep",
      "strace",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
