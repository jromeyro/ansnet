#!/usr/bin/bash
#
ansible="/usr/local/share/ansible"
# Backup Existing /usr/local/share/ansible/cisco/ios/lacp/roles/lacp/vars/main.yml
function makeBackup() {
    DateTimeStamp=$(date '+%m-%d-%y_%H:%M:%S')
    Original=$1
    FileName=$(basename $Original)
    Directory=$(dirname $Original)
    cp $Original ${Directory}/backup/${DateTimeStamp}_${FileName}
}

makeBackup /usr/local/share/ansible/cisco/ios/lacp/roles/lacp/vars/main.yml
#
# Remove Old Configurations
mv  $ansible/cisco/ios/lacp/output/lacp/*.txt $ansible/cisco/ios/lacp/output/lacp/backup
#
#ls -la $ansible/cisco/ios/lacp/roles/lacp/vars/backup/*
echo "This Script will create a main.yml file for the lacp configuration playbook"

echo -n "Install Type: install(i), update(u) or decomm(d): "
read pc_change_type

echo -n "Type the name of the first device: "
read host1

echo -n "Type the name of the second device: "
read host2

echo -n "Port Channel Number: "
read trunk_port_channel

if [ "$pc_change_type" == "i" ] || [ "$pc_change_type" == "d" ]; then
echo -n "First Port Channel $trunk_port_channel Member [TypeMod/Port] for $host1: "
read pc_channel_member_1

echo -n "$host1: $pc_channel_member_1 Peer Port Channel $trunk_port_channel Member [TypeMod/Port] on $host2: "
read peer_port_description_1

echo -n "Second Port Channel $trunk_port_channel Member [TypeMod/Port] for $host1: "
read pc_channel_member_2

echo -n "$host1: $pc_channel_member_2 Peer Port Channel $trunk_port_channel Member [TypeMod/Port] on $host2: "
read peer_port_description_2
fi
#
if [ "$pc_change_type" == "u" ]; then
	echo -n "Vlans List to Add: "
	read trunk_allowed_vlans_add
elif [ "$pc_change_type" == "i" ]; then
	echo -n "Vlans List for Port Channel (Examples: 1,3 1-10 1,3-10 or all): "
	read trunk_allowed_vlans
else
	echo " Not Needed"
fi

if  [ "$pc_change_type" == "u" ]; then
echo "
lacp:
 - {
host1: $host1,
host2: $host2,
pc_change_type: update,
portchannel_type: trunk_pc,
trunk_port_channel: $trunk_port_channel,
#
trunk_allowed_vlans_add: '$trunk_allowed_vlans_add',
}" > $ansible/cisco/ios/lacp/roles/lacp/vars/main.yml

elif [ "$pc_change_type" == "i" ]; then
echo "
lacp:
 - {
host1: $host1,
host2: $host2,
pc_change_type: install,
portchannel_type: trunk_pc,
trunk_port_channel: $trunk_port_channel,
#
pc_channel_member_1: $pc_channel_member_1,
peer_port_description_1: $peer_port_description_1,
#
pc_channel_member_2: $pc_channel_member_2,
peer_port_description_2: $peer_port_description_2,
#
trunk_allowed_vlans: '$trunk_allowed_vlans',
}" > $ansible/cisco/ios/lacp/roles/lacp/vars/main.yml

elif [ "$pc_change_type" == "d" ]; then
echo "
lacp:
 - {
host1: $host1,
host2: $host2,
pc_change_type: decomm,
portchannel_type: trunk_pc,
trunk_port_channel: $trunk_port_channel,
#
pc_channel_member_1: $pc_channel_member_1,
peer_port_description_1: $peer_port_description_1,
#
pc_channel_member_2: $pc_channel_member_2,
peer_port_description_2: $peer_port_description_2,
#
}" > $ansible/cisco/ios/lacp/roles/lacp/vars/main.yml
fi
cat $ansible/cisco/ios/lacp/roles/lacp/vars/main.yml
#
# Run Ansible Playbook
/usr/bin/ansible-playbook /usr/local/share/ansible/cisco/ios/lacp/lacp-play.yml
#
# Show Generated Configuration
cat $ansible/cisco/ios/lacp/output/lacp_trunk*
# eof
