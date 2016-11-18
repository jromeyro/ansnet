#!/bin/sh
/bin/rm -drf /usr/local/share/ansible/freeform/output/*.txt
/usr/local/bin/ansible-playbook -vvv /usr/local/share/ansible/freeform/freeform-build.yml
cat /usr/local/share/ansible/freeform/output/*.txt
