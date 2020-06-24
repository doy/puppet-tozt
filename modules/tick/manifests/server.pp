class tick::server {
  contain tick::server::influxdb
  contain tick::server::chronograf
  contain tick::server::kapacitor
}
