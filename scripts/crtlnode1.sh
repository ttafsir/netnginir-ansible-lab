#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install dos2unix
sudo apt-get install python-pip -y
sudo apt-get install  python-dev -y
sudo apt-get install git -y 
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install ansible -y
sudo apt-get install lldpd -y

echo export PYTHONPATH="/usr/share/ansible" >>/home/vagrant/.profile
sudo cp /etc/ansible/ansible.cfg ./ansible.cfg
sudo chown vagrant.vagrant ansible.cfg