# This Puppetfile generates a working Quartermaster for generating all necessary images.
#
# Git Settings
git_protocol=ENV['git_protocol'] || 'git'
base_url = "#{git_protocol}://github.com"

# 
branch_name = 'origin/grizzly'

# PuppetLabs
mod 'puppetlabs/postgresql', :git => "#{base_url}/puppetlabs/puppetlabs-postgresql", :ref => 'master'
mod 'puppetlabs/puppetdb', :git => "#{base_url}/puppetlabs/puppetlabs-puppetdb", :ref => 'master'
mod 'puppetlabs/firewall', :git => "#{base_url}/puppetlabs/puppetlabs-firewall", :ref => 'master'
mod 'puppetlabs/ntp', :git => "#{base_url}/puppetlabs/puppetlabs-ntp", :ref => 'master'
mod 'puppetlabs/apache', :git => "#{base_url}/puppetlabs/puppetlabs-apache", :ref => 'master'
mod 'puppetlabs/stdlib', :git => "#{base_url}/puppetlabs/puppetlabs-stdlib", :ref => 'master'
mod 'puppetlabs/apt', :git => "#{base_url}/puppetlabs/puppetlabs-apt", :ref => 'master'
mod 'puppetlabs/vcsrepo', :git => "#{base_url}/puppetlabs/puppetlabs-vcsrepo", :ref => 'master'
mod 'puppetlabs/mount_providers', :git => "#{base_url}/puppetlabs/puppetlabs-mount_providers", :ref => 'master'

# stephenrjohnson
mod 'stephenjohrnson/puppet', :git => "#{base_url}/stephenrjohnson/puppetlabs-puppet", :ref => 'master'

# upstream is ripienaar
mod 'ripienaar/concat', :git => "#{base_url}/ripienaar/puppet-concat", :ref => 'master'

# upstream is cprice-puppet/puppetlabs-inifile
mod 'cprice404/inifile', :git => "#{base_url}/cprice-puppet/puppetlabs-inifile"

# upstream saz/puppet-rsyslog
mod 'saz/rsyslog', :git => "#{base_url}/saz/puppet-rsyslog"

# Jenkins 
mod "jenkins", :git => "#{base_url}/ppouliot/puppet-jenkins"
