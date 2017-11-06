class nginx {
  include certbot

  include nginx::install
  include nginx::config
  include nginx::service

  Class['nginx::install'] -> Class['nginx::config']

  Class['nginx::config'] ~> Class['nginx::service']
  Class['nginx::install'] ~> Class['nginx::service']
  Nginx::Site<| |> ~> Class['nginx::service']
}
