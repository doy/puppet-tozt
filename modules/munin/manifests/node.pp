class munin::node {
  package { 'munin-node':
  }

  service { 'munin-node':
    ensure => running,
    enable => true,
    require => Package['munin-node'],
    subscribe => File['/etc/munin/munin-node.conf'];
  }

  file { '/etc/munin/munin-node.conf':
    content => template('munin/munin-node.conf'),
    require => Package['munin-node'];
  }

  # XXX backport a fix since the arch linux package is out of date
  # this can be removed once the arch package upgrades to at least 2.0.28
  exec { 'fix munin if plugin speed calculation':
    provider => shell,
    command => "sed -i 's/if \\[\\[ -n \"\$SPEED\" ]]; then/if [[ \"\$SPEED\" -gt 0 ]]; then/' /usr/lib/munin/plugins/if_",
    onlyif => "grep -qF 'if [[ -n \"\$SPEED\" ]]; then' /usr/lib/munin/plugins/if_",
    require => Package['munin-node'];
  }
}
