#############################
#
# basenode::joindomain
#
# Description:
#    Class to join a Windows machine to a Windows domain.
#
# Example usage:
#    class { 'basenode::joindomain': user_name => 'bossman', password => 'Passw0rd+', domain_name => 'nickdom.net' }
#
#############################

class basenode::joindomain (
  $user_name  = undef,
  $password   = undef,
  $domain_name = undef
){

  if $::osfamily == 'windows' {

    $code = "\$secPassword = ConvertTo-SecureString $password -AsPlainText -Force; \
      if (-not $?) { \
        'Error: Unable to convert password string to a secure string'; \
        exit 10 \
      } \
      \$creds = New-Object System.Management.Automation.PSCredential( '$user_name', \$secPassword ); \
      if (-not $?) { \
        'Error: Unable to create PSCredential object'; \
        exit 20 \
      }
      Add-Computer -domainName $domain_name -cred \$creds; \
      if (-not $?) {
        'Error: Unable to join domain'; \
        exit 30 \
      } \
      exit 0"

    exec { 'nick_test':
      #cwd       => 'C:/Public',
      group     => Administrators,
      command   => "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -executionpolicy RemoteSigned -command $code",
      provider  => windows,
      logoutput => true,
    }
  }
}

