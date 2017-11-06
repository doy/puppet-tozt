class nginx {
  include certbot

  include nginx::install
  include nginx::config
  include nginx::service

  nginx::install -> nginx::config -> nginx::service
}
