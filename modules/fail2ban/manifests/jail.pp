define fail2ban::jail($source=undef) {
  include fail2ban

  $_source = $source ? {
    undef => "puppet:///modules/fail2ban/jail/${name}.conf",
    default => $source,
  }

  file { "/etc/fail2ban/jail.d/${name}.conf":
    source => $_source,
    require => Package["fail2ban"],
    notify => Service["fail2ban"];
  }
}
