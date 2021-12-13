variable "student_ssh_pubkey" {
  description = "ssh public key of user"
  type        = string
}

variable "student_ssh_pubkey_name" {
  description = "The name of user ssh public key"
  type        = string
}

variable "student_ssh_private_key" {
  description = "Path to user's ssh private key"
  type        = string
}

variable "module_name" {
  description = "Name of the studied module"
  type        = string
}

variable "student_email" {
  description = "Student email address label"
  type        = string
}

variable "do_region" {
  description = "DO region"
  type        = string
}

variable "do_droplet_image" {
  description = "DO droplet image name"
  type        = string
  default     = "ubuntu-18-04-x64"
}

variable "do_droplet_size" {
  description = "DO droplet size"
  type        = string
}

variable "do_droplet_lb_name" {
  description = "Virtual machine name"
  type        = string
}

variable "do_droplet_app_name" {
  description = "Virtual machine name"
  type        = string
}

variable "do_droplet_app_instance_count" {
  description = "Count of app droplet instances"
  type        = number
  default     = 2
}

variable "inventory_file" {
  description = "Path to inverntory file"
  type        = string
}

variable "inventory_tmpl" {
  description = "Path to inventory template file"
  type        = string
}

variable "ansible_user" {
  description = "ansible username to connect to the remote host"
  type        = string
}

variable "rebrain_domain" {
  description = "Rebrain domain name for adding student subdomain"
  type        = string
  default     = "devops.rebrain.srwx.net"
}
variable "aws_region" {
  description = "AWS region for using in labs"
  type        = string
  default     = "us-west-2"
}
