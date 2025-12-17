class base::tools {
  include yay

  package {
    [
      "bat",
      "bc",
      "debugedit",
      "duf",
      "dust",
      "eza",
      "fzf",
      "ghostty-terminfo",
      "git-delta",
      "helix",
      "htop",
      "iftop",
      "iotop",
      "lsof",
      "man-db",
      "man-pages",
      "neomutt",
      "ncdu",
      "ripgrep",
      "starship",
      "stow",
      "strace",
      "tmux",
      "zellij",
    ]:
    ensure => 'installed';
  }
}
