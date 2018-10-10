class nginx {
  contain nginx::install
  contain nginx::config
  contain nginx::service

  Class['nginx::install'] -> Class['nginx::config']

  Class['nginx::config'] ~> Class['nginx::service']
  Class['nginx::install'] ~> Class['nginx::service']
  Nginx::Site<| |> ~> Class['nginx::service']
}
