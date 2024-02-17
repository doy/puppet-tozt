class base::tools {
  include yay

  package {
    [
      "bc",
      "debugedit",
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
      "stow",
      "strace",
      "tmux",
    ]:
    ensure => 'installed';
  }
}
