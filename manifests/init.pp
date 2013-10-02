class basenode {

  include params

  $ntp_servers = hiera('ntp_servers',{})
  $puppet_master = hiera('puppet_master',{})
  $nfs_mounts     = hiera('nfs_mounts',{})
  $nfs_packages = $params::nfs_packages


  notify {"Node: ${hostname}":}

  # Set NTP
  class {'ntp':
    servers => [ $ntp_servers ],
  } 

  class { 'puppet::agent':
    puppet_server             => $puppet_master,
    environment               => production,
    splay                     => true,
  }

if $kernel == 'Linux' { 
  package {$nfs_packages :
    ensure => latest,
  }

  create_resources(nfs_mounts,$nfs_mounts)

# SSH Keys and Authorized_Keys2 file

 file { '/root/.ssh':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0600,
  }
 file { '/root/.ssh/id_dsa':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => 0600,
    source  => "puppet:///extra_files/id_dsa",
  }

 file { '/root/.ssh/id_dsa.pub':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => 0600,
    source  => "puppet:///extra_files/id_dsa.pub",
  }

  file { '/root/.ssh/authorized_keys':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0600,
    source  => "puppet:///extra_files/id_dsa.pub",
    require => File[ '/root/.ssh' ],
  }
 }
}
