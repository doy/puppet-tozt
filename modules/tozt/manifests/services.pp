class tozt::services {
  include metabase

  fail2ban::jail { ["sshd", "nginx-botsearch"]:
  }
}
