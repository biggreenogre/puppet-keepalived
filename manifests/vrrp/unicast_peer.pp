# == Define: keepalived::vrrp::unicast_peer
#
# === Parameters:
#
# $name::     IP address of unicast peer
# $instance:: Name of vrrp instance this peer belongs to
#
define keepalived::vrrp::unicast_peer (
  $instance,
) {
  $_inst = regsubst($instance, '[:\/\n]', '')
  $_name = regsubst($name, '[:\/\n\.]', '_')
  
  validate_string( $name )
  validate_ip_address( $name )
  notify { "unicast_peer_${name}": message => "\nInstance=${instance}:\npeer=${name}:\n" }
  
  if ! has_ip_address( $name ) {
    concat::fragment { "keepalived.conf_vrrp_instance_${_inst}_upeers_peer_${_name}":
      target  => "${::keepalived::config_dir}/keepalived.conf",
      content => "    ${name}\n",
      order   => "100-${_inst}-020",
    }
  }
}

