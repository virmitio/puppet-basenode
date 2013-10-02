#
#
#

class basenode ( $puppet_master, $ntpserver ){
  include basenode::params
  include basenode::sshd
  include basenode::users

# Configure Puppet Agent

  class { 'puppet::agent':
    puppet_server             => $puppet_master,
    environment               => production,
    splay                     => true,
  }

  file {'/etc/puppet/hiera.yaml':
    ensure  => file,
    source  => 'puppet:///basenode/files/hiera.yaml',
    require => Class['puppet::agent'],
    notify  => Service['puppet'],
  }

  file {'/etc/puppet/hiera'
    ensure => directory,
    require => Class['puppet::agent'],
    notify  => Service['puppet'],
  }

  class { 'ntp':
    servers => $ntpserver,
  }

# SSH Key Files on for root access  

  file { '/root/.ssh':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0600,
  }

  file { '/root/.ssh/authorized_keys':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0600,
    source  => "puppet:///extra_files/id_dsa.pub",
    require => File[ '/root/.ssh' ],
  }

# Manage NFS Mount  
  class mount_providers {
    mount_providers::do { '/nfs':
      device => 'quartermaster.openstack.tld:/srv/nfs',
      options => ['ro','hard'],
    }
  }

#  class { 'jenkins::slave':
#     masterurl => 'jenkins.openstack.tld',
#  }

  @basenode::virtual_user{'jenkins-slave':
    uid      => 500,
    realname => 'Jenkins Slave Account',
  }

}

