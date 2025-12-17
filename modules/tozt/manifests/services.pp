class tozt::services {
  include nftables
  
  fail2ban::jail { ["sshd", "nginx-botsearch"]:
  }
}
