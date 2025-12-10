class tozt::services {
  fail2ban::jail { ["sshd", "nginx-botsearch"]:
  }
}
