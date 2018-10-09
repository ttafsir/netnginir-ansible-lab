#!/usr/bin/env bash
sudo apt-get update
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install ansible -y
sudo apt-get install git -y

sudo apt-get install python-pip python-dev libffi-dev -y 
sudo apt-get install lldpd -y

sudo usermod -aG sudo vagrant
echo export PYTHONPATH="/usr/share/ansible" >>/home/vagrant/.profile

# copy the ansible folder to the Ansible control node
sudo cp -r /vagrant/ansible .
sudo chown -R vagrant.vagrant ./ansible
sudo cp /etc/ansible/ansible.cfg ./ansible/ansible.cfg
sudo chown vagrant.vagrant ./ansible/ansible.cfg

# Add vEOS switch to /etc/host file for name resolution
sudo echo '10.10.10.11 switch1' >> /etc/hosts
#sudo echo '10.10.10.12 switch2' >> /etc/hosts

# Add basic vEOS switch to default inventory
sudo echo '
[all:vars]
# these defaults can be overridden for any group in the [group:vars] section
ansible_connection=network_cli
ansible_user=vagrant

[eos:vars]
ansible_network_os=eos 

[eos]
switch1
switch2
' >> /etc/ansible/hosts

# set host_key_checking = False
sed -i '/host_key_checking/s/^#//g' ./ansible/ansible.cfg

