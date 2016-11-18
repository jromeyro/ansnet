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

The root of all the roles listed was the "Freeform" role, du to it ability to push to any device as long as it is supprted by Netmiko or NAPALM.
