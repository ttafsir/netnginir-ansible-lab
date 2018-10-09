#!/usr/bin/env bash
FastCli -p 15 -c "
enable
configure terminal
!
hostname switch2
!
interface Ethernet1
  description MGMT_NET_vagrant
  no switchport
  ip address 10.10.10.12/24
  no shutdown
!
username vagrant privilege 15 role network-admin secret vagrant
management api http-commands
  no shutdown
end
copy running-config startup-config
"