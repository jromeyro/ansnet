# ansnet

The intention of AnsNet is to create a user friendly orchestration system, for network environment builds.
It is based on Ansible, NAPALM and Netmiko libraries in order to provide multivendor configuration push.
The Ansible roles are divided according Vendors and Function

Example Role Splits:
- Ansible
 - Cisco
   - roles
     - ios
        - catalyst_basic_switch_builds
        - catalyst_switch_trunks
        - catalyst_switch_lacp
        - catalyst_spine_leaf_builds
        - ios_based_tacacs
        - ios_bgp_ebgp
        - ios_bgp_ibgp
      - nxos
        - nexus_vpc_peers
        - nexus_downstream_vpcs
 - Juniper
   - roles
     - junos
        - junos_switch_ports
        - junos_bgp_peerings
 - Arista
   - roles
     - eos
        - eos_switch_ports
        - eos_bgp_peerings
 - Freeform
   - roles
     - anyos
        - freeform_builds
    
For enhanced user experience a web browser interface is part of the system.

The root of all the roles listed was the "Freeform" role, due to its ability to push to any device as long as it is supported by Netmiko or NAPALM.

AnsNet was built in FreeBSD 11.

I've included a simple Update Playbook to show a the cross integration within Ansible. Also to show that the same system can be used not just for the purpose of Network Builds but also create tasks to administer the ansnet host system. The playbook is the only one in AnsNet that runs dependent in the host file (included in the repository).
From Playbook
---
- hosts: freebsd << Calls freebsd group in the hosts file. Normally located in /usr/local/ets/ansible/hosts

The playbook can be ran on demand via command (ansible-playbook -vvv /usr/local/share/ansible/freebsd) a shell script or scheduled CRON.

