#
#
#

class basenode::puppet_agent ($ci_puppet_master= "puppet.example.com") {

  file { '/etc/puppet/puppet.conf':
    path    => '/etc/puppet/puppet.nick',
    ensure  => file,
#    require => Package [ 'puppet' ],
    content => template("basenode/puppet.conf.erb"),
  }
}

