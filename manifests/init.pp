#
#
#

class basenode(
  puppet_master_url = 'foo.example.com'
) {
  include basenode::sshd
  include basenode::users
  class { 'basenode::puppet_agent': ci_puppet_master => $puppet_master_url }
  include basenode::nfs

#  class { '::ntp':  servers => ['bonehead.lcs.mit.edu'] } 
   class { 'ntp':    servers => ['bonehead.lcs.mit.edu'] }
#  class { 'jenkins::slave':  masterurl => 'nick.com' }
}

