#puppet/manifests/site.pp

package {'openvpn':
    ensure => installed,
}

include client_fw