#
# basenode::users
#
# Description:
#    The basenode_user class performs the following tasks:
#    - Remove the user account created during the basenode
#      provisioning process. This accuount is named avter
#      the Linux distribution.  For example: Ubuntu
#
#    - Create a user account for the Jenkins slave.  
#      We will use the name 'jenkins-slave'
#
#    - Give the root account an SSH key to allow us to
#      send commands to the host to finish configuring the
#      host.
#

class basenode::users {

  $user_to_remove = $operatingsystem
  $root_ssh_pub_key_name = 'rhel5_id_rsa.pub'

  notify { "xyz":
    message => "OS = ${operatingsystem}",
  }

  #
  # Remove the legacy user created during the provisioning process.
  # The username will be the name of the OS: Ubuntu, CentOS, ...
  #
  user { $user_to_remove:
    ensure     => absent,
  }

  file { "/home/${user_to_remove}":
    ensure => absent,
    force  => true,
    subscribe => User[ $user_to_remove ],
  }

  #
  # Create a user for Jenkins
  #
#  user { 'jenkins-slave':
#    ensure     => present,
#    comment    => 'Jenkins slave account',
#    home       => '/home/jenkins-slave',
#    managehome => true,
#  }

  #
  # Add a ssh key to the root user
  #
  file { '/root/.ssh':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0600,
  }

  file { $root_ssh_pub_key_name:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0600,
    path    => "/root/.ssh/${root_ssh_pub_key_name}",
    source  => "puppet:///modules/basenode/${root_ssh_pub_key_name}",
    require => File[ '/root/.ssh' ],
  }

  file { '/root/.ssh/authorized_keys':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0600,
    path    => '/root/.ssh/authorized_keys',
    source  => "puppet:///modules/basenode/${root_ssh_pub_key_name}",
    require => File[ '/root/.ssh' ],
  }
}

