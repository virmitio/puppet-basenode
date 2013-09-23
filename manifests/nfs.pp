#
# basenode_nfs
#
# Description:
#    Install the packages required for the nfs client, and create the
#    nfs mount point (/nfs) used while provisioning the basenode.
#

class basenode::nfs {

  $nfs_mount_root = '/nfs'

  case $operatingsystem
  {
    /(Ubuntu|Debian)/:
    {
      $nfs_packages = [ "portmap", "nfs-common" ]
    }
    /(Red Hat|CentOS|Fedora)/:
    {
      $nfs_packages = [ "nfs-utils", "nfs-utils-lib", "portmap", "system-config-nfs" ]
    }
  }

  #
  # Install the packages required by the NFS client
  #
  package { [$nfs_packages]:
    ensure  => installed,
  }

  #
  # Create our mountpoint
  #

  file { $nfs_mount_root:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => 0755,
  }

  file {"${nfs_mount_root}/${hostname}":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => 0755,
    require => File[ $nfs_mount_root ],
  }

}

