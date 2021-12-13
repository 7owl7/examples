terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}

provider "aws" {
  region = var.aws_region
}

data "aws_route53_zone" "selected" {
  name = "${var.rebrain_domain}."
}

resource "digitalocean_ssh_key" "sshkey_user" {
  name       = var.student_ssh_pubkey_name
  public_key = var.student_ssh_pubkey
}

resource "digitalocean_tag" "module" {
  name = var.module_name
}

resource "digitalocean_tag" "email" {
  name = var.student_email
}

resource "digitalocean_droplet" "lb" {
  region   = var.do_region
  image    = var.do_droplet_image
  name     = var.do_droplet_lb_name
  size     = var.do_droplet_size
  ssh_keys = [digitalocean_ssh_key.sshkey_user.id]
  tags     = [digitalocean_tag.module.id, digitalocean_tag.email.id]
}

resource "digitalocean_droplet" "app" {
  region   = var.do_region
  count    = var.do_droplet_app_instance_count
  image    = var.do_droplet_image
  name     = var.do_droplet_app_name
  size     = var.do_droplet_size
  ssh_keys = [digitalocean_ssh_key.sshkey_user.id]
  tags     = [digitalocean_tag.module.id, digitalocean_tag.email.id]
}

resource "local_file" "ansible_inventory" {
  count = var.do_droplet_app_instance_count
  content = templatefile(var.inventory_tmpl, {
    lb_ipv4_address          = digitalocean_droplet.lb.ipv4_address
    lb_ipv4_address_private  = digitalocean_droplet.lb.ipv4_address_private
    app_ipv4_address         = digitalocean_droplet.app.*.ipv4_address
    app_ipv4_address_private = digitalocean_droplet.app.*.ipv4_address_private
    admin_ssh_pr_key         = var.student_ssh_private_key
    ansible_user             = var.ansible_user
  })
  filename = var.inventory_file
}

resource "null_resource" "nginx-lb_provision" {
  provisioner "remote-exec" {
    inline = ["echo VM started"]
    connection {
      type        = "ssh"
      host        = digitalocean_droplet.lb.ipv4_address
      user        = "root"
      private_key = file(pathexpand(var.student_ssh_private_key))
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  ansible/pb_main.yml"
  }
  depends_on = [
    local_file.ansible_inventory,
    aws_route53_record.lb_domain,
  ]
}


resource "aws_route53_record" "lb_domain" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "${var.student_email}.${var.rebrain_domain}"
  type    = "A"
  ttl     = "300"
  records = [digitalocean_droplet.lb.ipv4_address]
}

output "lab_domain_name" {
  value = aws_route53_record.lb_domain.fqdn
}
