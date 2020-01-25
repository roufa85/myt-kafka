
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "1"
  end

  N = 2..0
  (N.first).downto(N.last).each do |node_id|
    config.vm.define "node#{node_id}" do |node|
      node.vm.hostname = "node#{node_id}"
      node.vm.network "private_network", ip: "192.168.2.#{110+node_id}"

      # Only execute once the Ansible provisioner, when all the machines are up and ready.
      if node_id == 0
        (N.first).downto(N.last).each do |id|
          if id != 0
            node.vm.provision "file", source: ".vagrant/machines/node#{id}/virtualbox/private_key",
                                      destination: "/home/vagrant/machines/node#{id}.private_key"
          end
        end
        node.vm.provision "shell", path: "scripts/update_hostkeys.sh"
        node.vm.synced_folder "ansible/", "/home/vagrant/ansible"

        node.vm.provision :ansible_local do |ansible|
          ansible.playbook       = "ansible/hosts.yml"
          ansible.install        = true
          ansible.verbose        = true
          ansible.limit          = "all"
          ansible.inventory_path = "ansible/inventory"
        end

        node.vm.provision :ansible_local do |ansible|
          ansible.playbook       = "ansible/monitoring.yml"
          ansible.verbose        = true
          ansible.limit          = "monitoring"
          ansible.inventory_path = "ansible/inventory"
        end

        node.vm.provision :ansible_local do |ansible|
          ansible.playbook       = "ansible/kafka.yml"
          ansible.verbose        = true
          ansible.limit          = "kafka"
          ansible.inventory_path = "ansible/inventory"
        end

      end

    end
  end
end