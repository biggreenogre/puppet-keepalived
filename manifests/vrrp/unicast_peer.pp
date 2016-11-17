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
  
  notify { "unicast_peer_${hostname}": message => "\nInstance=${instance}\n"}
  
  validate_string( $name )
  validate_ip_address( $name )
  
  if ! has_ip_address( $name ) {
    concat::fragment { "keepalived.conf_vrrp_instance_${_inst}_upeers_peer_${name}":
      target  => "${::keepalived::config_dir}/keepalived.conf",
      content => "    ${name}\n",
      order   => "100-${_inst}-011",
    }
  }
}

