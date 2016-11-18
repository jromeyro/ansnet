#!/usr/bin/env python2

import netmiko
from netmiko import ConnectHandler
from os.path import expanduser
import os, sys, getopt
from datetime import datetime

separator = "----------------------"
newline = ""

def main(argv):
   vendor = ''
   hostname = ''
   user = ''
   passwd = ''
   command_file = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["vendor=","hostname=","username=","password=","command_file="])
   except getopt.GetoptError:
      print 'For Help type netmiko_push.py -h'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print '---------------------------------------------------------------------------------------------------------------------'
         print 'Help'
         print 'Usage: netmiko_push.py <vendor_type> <hostname or ip> <username> <password> <commands_file> <show run | start command>'
         print ''
         print 'Available vendor types:'
         print 'Type "vendors" in lieu of the vendor_type variable for other vendor type options'
         print ''
         print 'Note: Input Folder:'
         print 'Make sure that the folder containing your "commands_file" is set in the "base_dir" variable'
         print 'in the netmiko_push.py script'
         print '---------------------------------------------------------------------------------------------------------------------'
         sys.exit()
if __name__ == "__main__":
   main(sys.argv[1:])

base_dir = "/usr/local/share/ansible/freeform"
vendor = sys.argv[1]
hostname = sys.argv[2]
user = sys.argv[3]
passwd = sys.argv[4]
command_file = sys.argv[5]
commands =  os.path.join(base_dir + "/" + command_file)

start_time = datetime.now()

device = ConnectHandler(device_type=vendor, ip=hostname, username=user, password=passwd)
device.enable()
device.find_prompt()
cfg = device.send_config_from_file(commands)
print(cfg)
device.send_command_expect('write memory')

print(newline)
end_time = datetime.now()
total_time = end_time - start_time
print(separator)
print('Script Execution TIme:')
print(total_time)
print(separator)

exit()
