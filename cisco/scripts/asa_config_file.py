#!/usr/bin/env python2

import netmiko
from netmiko import ConnectHandler
from os.path import expanduser
import os, sys, getopt
from datetime import datetime

separator = "----------------------"
newline = ""

device = {
    'device_type': 'cisco_asa',
    'ip': sys.argv[1],
    'username': 'ansible',
    'password': 'ansible',
    'secret': 'ansible!',
    'port': 22,
}

base_dir = "/usr/local/share/ansible/cisco"
command_file = sys.argv[2]
commands =  os.path.join(base_dir + "/" + command_file)

start_time = datetime.now()

net_connect = ConnectHandler(**device)
cfg = net_connect.send_config_from_file(commands)
print (cfg)
net_connect.send_command_expect('write memory')

print(newline)
end_time = datetime.now()
total_time = end_time - start_time
print(separator)
print('Script Execution TIme:')
print(total_time)
print(separator)

exit()
