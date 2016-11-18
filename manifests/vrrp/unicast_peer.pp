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
  
  validate_string( $title )
  validate_ip_address( $title )
  notify { "unicast_peer_${name}": message => "\nInstance=${instance}:\npeer=${title}:\n" }
  
  if ! has_ip_address( $title ) {
    concat::fragment { "keepalived.conf_vrrp_instance_${_inst}_upeers_peer_${name}":
      target  => "${::keepalived::config_dir}/keepalived.conf",
      content => "    ${title}\n",
      order   => "100-${_inst}-020",
    }
  }
}

