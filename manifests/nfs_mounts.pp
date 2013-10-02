define nfs_mounts($device,$options){

  mount_providers::do { $name:
    device => $device,
    options => $options,
    require => Package[$basenode::nfs_packages],
  }

  file {"${name}/${hostname}":
    ensure => directory,
    require => Mount_providers::Do[$name],
  }

  file {"${name}/${hostname}/dns.yaml":
    ensure => file,
#    content => template('ipam/dns_record.erb'),
    require => File["${name}/${hostname}"],
  }

  file {"${name}/${hostname}/dhcp.yaml":
    ensure => file,
#    content => template('ipam/static_ip.erb'),
    require => File["${name}/${hostname}"],
  }


}
