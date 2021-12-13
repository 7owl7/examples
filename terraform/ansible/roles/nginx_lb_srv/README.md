# Ansible nginx_lb_srv role

This role creates simple nginx reverse proxy configuration with ssl certificates.

## Requirements:  
- Ubuntu OS on target host
- Installed nginx
- Ansible
- Application server configured
- Previously installed LetsEncrypt SSL certificates for required domains

## Role Variables
The descriptions and defaults for all variables can be found in the defaults/main.yml file.

## Example Playbook
```yaml
  become: yes
  become_user: root  
  roles:  
  - role: nginx_lb_srv   
```