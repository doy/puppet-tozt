class vpn {
  include vpn::ca;

  package { 'openvpn':
    ensure => installed;
  }
}
