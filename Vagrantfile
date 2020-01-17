
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox"

  config.vm.define "node1" do |node1|
    node1.vm.network "private_network", ip: "192.168.2.110"
  end
  
  config.vm.define "node2" do |node2|
    node2.vm.network "private_network", ip: "192.168.2.111"
  end

end
