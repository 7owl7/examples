# Пример кода terraform\ansible
## Задача:
- Написать terraform-файл, который создает два VPS. Оба VPS должны быть настроены с помощью ansible, используя local-exec provisioner.
- На обоих VPS установить nginx.
- Настроить nginx на первом VPS как load balancer и проксировать все запросы через proxy_pass + upstream на второй VPS.
- Настроить nginx на втором VPS как сервер приложения с любым статическим html.
- На VPS должны быть корректно исправлены hostname, и файл inventory для Ansible должен заполняться автоматически.
