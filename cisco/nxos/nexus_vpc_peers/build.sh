#!/bin/sh
/bin/rm -drf /usr/local/share/ansible/cisco/output/switches/nexus-vpc/*.txt
/usr/local/bin/ansible-playbook -vvv /usr/local/share/ansible/cisco/nexus_vpc_peers-build.yml


