require 'facter'
Facter.add("homedir") do
  confine :kernel => "Linux"
  setcode do
  Facter::Util::Resolution.exec( "echo $HOME")
  end
end

