# Ansible nginx role

This role generates the letsencrypt ssl certificate for the nginx virtual host, adds the certificate to the nginx virtual host configuration, and creates a cron job to renew the certificate.

## Requirements:  
- Ubuntu OS on target host
- Installed nginx with virtual host configured
- Ansible

## Role Variables
The descriptions and defaults for all variables can be found in the defaults/main.yml file.

## Example Playbook
```yaml
  become: yes
  become_user: root  
  roles:  
  - role: letsencrypt
```