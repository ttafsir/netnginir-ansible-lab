# netnginir-ansible-lab
Simple lab to get up-and-running quickly with Ansible in a local virtual environment geared towards network automation. The lab includes:

- One Ubuntu VM configured as an Ansible control node
- Two virtual Arista devices 


## Instructions
We will cover the following items to get you started:
1. Installing the required tools
2. Creating the virtual lab with an Arista device
3. Accessing the challenge labs


## Required Tools
The following tools are required for this lab:
- [VirtualBox](https://www.virtualbox.org): Free and open-source [hosted](https://en.wikipedia.org/wiki/Hypervisor#Classification) hypervisor for x86 computers. Virtualbox runs on Windows, Linux, Mac, and Solaris hosts.
- [Vagrant](https://www.vagrantup.com): Vagrant is a tool for building and managing virtual machine environments. Vagrant works on Mac, Linux, Windows hosts.
- [Git](https://git-scm.com): free, [easy to learn](https://git-scm.com/doc), open source version control system 
- Arista vEOS vagrant box (we'll cover the details later)


## Getting started with the lab
Once VirtualBox and Vagrant have been installed, we'll need to download a virtual Arista device. Arista allows the vEOS images to be downloaded for free using the following steps:

1. [Create an account](https://www.arista.com/en/user-registration)
2. [Navigate to download section](https://www.arista.com/en/support/software-download)
3. Dowload the latest 'vEOS-lab-`<version>`-virtualbox.box'
	* This lab uses `vEOS-lab-4.20.1F-virtualbox.box`


## Usage 
### Add vagrant box 
Add the vEOS vagrant box to the vagrant box list, ensuring that the version matches the version that you downloaded from Arista. Assuming that you downloaded `vEOS-lab-4.20.1F-virtualbox.box` in `~/Downloads`, you would add the vagrant box as follows:

```
$ vagrant box add --name 'vEOS-lab-4.20.1F' ~/Downloads/vEOS-lab-4.20.1F-virtualbox.box
```

verify that the box has been added to the list

```
$ vagrant box list
vEOS-lab-4.20.1F (virtualbox, 0)
```


### Clone this repository
The following step requires that you have [git](https://git-scm.com) installed.

```
git clone http://10.253.185.27/ttafsir/vagrant-veos-netwrks.git
```


### Vagrant Up!
Change to the cloned directory, and bring up the lab devices. the login information for all of the devices in the lab is set to **vagrant/vagrant**. Note that only the control node and switch1 will be started by default. If you'd like to start switch2, you must run `vagrant up switch2`. Please note that each vEOS switch requires 2048 MB.

```
cd vagrant-veos-netwrks
vagrant up
```

Connect to Ansible control node
```
vagrant ssh ctrlnode1
```

Test connectivity to switch1
```
vagrant@ubuntu-xenial:~$ ping switch1
vagrant@ubuntu-xenial:~$ ssh vagrant@switch1 
```

### connecting to vEOS
You can also ssh to the vEOS switch directly from the Vagrant host (your workstation) using `vagrant ssh`. However, you will be placed in the EOS bash shell when you do.

```
vagrant-veos-netwrks thiamt$ vagrant ssh switch1

Arista Networks EOS shell

-bash-4.3# 

```

To connect to the EOS CLI, type `FastCli` at the bash shell.

```
-bash-4.3# FastCli
switch1>enable
switch1#
```

An alternative method to connecting to the vEOS switch is to ssh to the virtual switch without using `vagrant ssh`. This will take you directly to the EOS CLI.

```
ssh vagrant@localhost -p 2200
```

If you do not know which port ssh was forwarded to on your host, you can run `vagrant port` to display the mappings.

```
vagrant port switch1
```

### Ansible Demo
If the lab environment was correctly provisioned, you should be able to connect to the control node and successfully run the demo playbook.

```
vagrant ssh ctrlnode1
cd ansible
ansible-playbook demo-playbook.yml
```

### Vagrant Halt & Vagrant Destroy
Once you're done with the lab, you can run `vagrant halt` to stop the VMs. You can also remove the VMs completely by running `vagrant destroy`.