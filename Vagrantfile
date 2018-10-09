# -*- mode: ruby -*-
# vi: set ft=ruby :
SWITCHBOX = 'vEOS-lab-4.20.1F'

Vagrant.configure("2") do |config|

  # Management VM running Ansible; This box will be downloaded and added if you don't have it already.
  config.vm.define 'ctrlnode1' do |ctrlnode1|
    ctrlnode1.vm.box = 'ubuntu/xenial64'
    ctrlnode1.vm.network 'private_network', ip: '10.10.10.10'

    ctrlnode1.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "MGMT_NET"]
      end
    ctrlnode1.vm.provision "shell", path: "scripts/ctrlnode1.sh"
  end


  config.vm.define 'switch1' do |switch1|
    switch1.vm.box = SWITCHBOX
    switch1.vm.boot_timeout = 500
    switch1.ssh.insert_key = false

    switch1.vm.network "forwarded_port", guest: 443, host: 4041

    # Network Interfaces
    switch1.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "MGMT_NET"]
      v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "SW1_SW2"]
      end
    switch1.vm.provision "shell", path: "scripts/switch1-config.sh"
  end

  # Switch2 doesn't start by default with 'vagrant up'; you must specify 'vagrant up switch2'
  # This is useful when you do not have enough memory to run all 3 machines.
  config.vm.define 'switch2', autostart: false do |switch2|
    switch2.vm.box = SWITCHBOX
    switch2.vm.boot_timeout = 500
    switch2.ssh.insert_key = false

    switch2.vm.network "forwarded_port", guest: 443, host: 4042

    # Network Interfaces
    switch2.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "MGMT_NET"]
      v.customize ["modifyvm", :id, "--nic3", "intnet", "--intnet3", "SW1_SW2"]
      end
    switch2.vm.provision "shell", path: "scripts/switch2-config.sh"
  end
end