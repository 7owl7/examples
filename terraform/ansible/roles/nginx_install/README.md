# Ansible nginx role

This role installs the NGINX Open Source on your target host and creates nginx.conf configuration file with required options.

## Requirements:  
- Ubuntu OS on target host
- Ansible

## Role Variables
The descriptions and defaults for all variables can be found in the defaults/main.yml file.

## Example Playbook
```yaml
  become: yes
  become_user: root  
  roles:
  - nginx_install  
```