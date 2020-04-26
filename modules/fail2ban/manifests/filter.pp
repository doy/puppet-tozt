define fail2ban::filter($source=undef) {
  include fail2ban

  $_source = $source ? {
    undef => "puppet:///modules/fail2ban/filter/${name}.conf",
    default => $source,
  }

  file { "/etc/fail2ban/filter.d/${name}.conf":
    source => $_source,
    require => Package["fail2ban"],
    notify => Service["fail2ban"];
  }
}
