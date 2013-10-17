class basenode::pxefile {

  $arp_type = '01'

  $host_macaddress = regsubst($macaddress, '(\.)','(\-)','G')



  file {"/nfs/${hostname}/${arp_type}${host_macaddress}":
    ensure => file,
    content => template('basenode/pxefile.erb'),
    require => File["/nfs/${hostname}"],
  }

}
