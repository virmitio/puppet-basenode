class basenode::pxefile {

  $arp_type => '01'

  $host_macaddress = regsubst($macaddress, '(\.)','(\-)','G')



  file {"${name}/${hostname}/${arp_type}${host_macaddress}":
    ensure => file,
    content => template('quartermaster/node_pxe_file.erb'),
    require => File["${name}/${hostname}"],
  }

}
