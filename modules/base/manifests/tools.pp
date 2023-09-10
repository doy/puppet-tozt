class base::tools {
  include yay

  package {
    [
      "bc",
      "eza",
      "fzf",
      "git-delta",
      "helix",
      "htop",
      "iftop",
      "iotop",
      "lsof",
      "neomutt",
      "ncdu",
      "ripgrep",
      "starship",
      "strace",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
