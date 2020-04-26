class mail::services {
  fail2ban::filter { "mailu":
  }
  fail2ban::jail { ["sshd", "mailu"]:
    require => Fail2ban::Filter["mailu"],
  }
}
