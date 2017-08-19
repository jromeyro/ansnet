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

## Options in Playbook Tasks
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

> Ecrypting the `secrets.yml` file
```
$ansible-vault encrypt secrets.yml
New Vault password: your_secret_password
Confirm New Vault password: your_secret_password
```

> Running the Playbook with encrypted `secrets.yml`

Password Prompted:
```
ansible-playbook sco-cli-push.yml --ask-vault-pass -i hosts
```

No password prompt:
Create a file containing the vault password (vault_pass.py or anything else) and lock down permissions
`chmod 600 vault_pass.py`
Running Playbook:
```
ansible-playbook site.yml --vault-password-file vault_pass.py - i hosts
```

Editing Encrypted files in vault
```
$ansible-vault edit secrets.yml
Vault password: your_secret_password
```
Or
```
$ansible-vault edit secrets.yml --vault-password-file vault_pass.py
```