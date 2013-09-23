#
# basenode::sshd
#
# Description:
#   Manage SSHD with puppet
#
#

class basenode::sshd {

  #
  # Compute the parameters the resource definitions require
  # to do their work.
  #
  case $operatingsystem {
    Solaris: {
      $sshd_package_name = 'openssh'
      $sshd_config_file  = '/etc/ssh/sshd_config'
      $sshd_service_name = 'sshd'
    }
    /(Ubuntu|Debian)/: {
      $sshd_package_name = 'openssh-server'
      $sshd_config_file  = '/etc/ssh/sshd_config'
      $sshd_service_name = 'ssh'
    }
    /(Red Hat|CentOS|Fedora)/: {
      $sshd_package_name = 'openssh-server'
      $sshd_config_file  = '/etc/ssh/sshd_config'
      $sshd_service_name = 'sshd'
    }
  }

  #
  # Install the SSHD package
  #
  package { $sshd_package_name:
    ensure  => installed,
  }

  #
  # Manage the sshd_config file
  #
  file { $sshd_config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    source  => "puppet:///modules/basenode/sshd_config",
    require => Package[ $sshd_package_name ],
  }

  #
  # Manage the SSHD service
  #
  service { $sshd_service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => File[ $sshd_config_file ],
  }

}

