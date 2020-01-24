
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "1"
end
  
  config.vm.define "node1" do |node1|
    node1.vm.network "private_network", ip: "192.168.2.111"    
    # node1.vm.provision "docker" do |docker|
    # end
  end
  
  # config.vm.define "node2" do |node2|
  #   node2.vm.network "private_network", ip: "192.168.2.112"
  # end
  
  # config.vm.define "node3" do |node3|
  #   node3.vm.network "private_network", ip: "192.168.2.113"
  # end

  config.vm.define 'controller' do |machine|
    machine.vm.network "private_network", ip: "192.168.2.110"
    machine.vm.provision "file", source: ".vagrant/machines/node1/virtualbox/private_key",
                                destination: "/home/vagrant/machines/node1.private_key"
    
    machine.vm.provision "shell", path: "scripts/update_hostkeys.sh"

    machine.vm.synced_folder "provision/", "/vagrant/provision"

    machine.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "provision/playbook.yml"
      ansible.verbose        = true
      ansible.install        = true
      ansible.limit          = "all" # or only "node1" group for monitoring stack.
      ansible.inventory_path = "inventory"
    end

    # machine.vm.provision :ansible_local do |ansible|
    #   ansible.playbook       = "provision/monitoring.yml"
    #   ansible.verbose        = true
    #   ansible.install        = true
    #   ansible.limit          = "node1"
    #   ansible.inventory_path = "inventory"
    # end

    # machine.vm.provision :ansible_local do |ansible|
    #   ansible.playbook       = "provision/common.yml"
    #   ansible.verbose        = true
    #   ansible.install        = true
    #   ansible.limit          = "node1"
    #   ansible.inventory_path = "inventory"
    # end

    # machine.vm.provision :ansible_local do |ansible|
    #   ansible.playbook       = "provision/zookeeper.yml"
    #   ansible.verbose        = true
    #   ansible.install        = true
    #   ansible.limit          = "node1"
    #   ansible.inventory_path = "inventory"
    # end

    # machine.vm.provision :ansible_local do |ansible|
    #   ansible.playbook       = "provision/kafka.yml"
    #   ansible.verbose        = true
    #   ansible.install        = true
    #   ansible.limit          = "node1"
    #   ansible.inventory_path = "inventory"
    # end

  end

end