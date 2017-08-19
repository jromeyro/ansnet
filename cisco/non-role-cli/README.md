# Non Role Based Playbook
Template for non role based ios, on demmand configuration. Uses Ansible modules.
Usage:
```
ansible-playbook cisco-cli-push.yml -i hosts
```

With debug:
```
ansible-playbook -vvv cisco-cli-push.yml -i hosts
```

> Options in Playbooks
```yml
- name: IOS Configuration #1
  ios_config:
    provider: "{{ provider }}"
    lines:
      - [configuration line]
    # Makes a backup of the running configuration to the playbook's folder (backup/)
    backup: yes
    # Saves running Configuration
    save: yes 
```