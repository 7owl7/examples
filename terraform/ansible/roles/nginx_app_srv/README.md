# Ansible nginx_app_srv role

This role creates a simple nginx-based application server imitation.
## Requirements:  
- Ubuntu OS on target host
- Installed nginx
- Ansible

## Role Variables
The descriptions and defaults for all variables can be found in the defaults/main.yml file.

## Example Playbook
```yaml
  become: yes
  become_user: root  
  roles:  
  - role: nginx_app_srv
```