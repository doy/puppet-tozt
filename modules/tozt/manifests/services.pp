class tozt::services {
  include ufw
  
  fail2ban::jail { ["sshd", "nginx-botsearch"]:
  }
}
