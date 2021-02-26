#########
# Ansible
#########
variable "playbook_vars" {
  description = "Additional playbook vars"
  type        = map(string)
  default     = {}
}

variable "verbose" {
  description = "Verbose ansible run"
  type        = bool
  default     = false
}

variable "certbot_admin_email" {
  type    = string
  default = ""
}

locals {
  playbook_vars = merge({
    network_name           = var.network_name,
    instance_type          = var.instance_type,
    instance_store_enabled = local.instance_store_enabled,
    this_instance_id       = join("", aws_instance.this.*.id),
    dhcp_ip                = join("", aws_instance.this.*.public_ip),
    certbot_admin_email    = var.certbot_admin_email
    ssl_enable             = var.domain_name == "" ? false : true
    fqdn                   = var.domain_name == "" ? "" : var.hostname == "" ? var.domain_name : "${var.hostname}.${var.domain_name}"
  }, var.playbook_vars)
}

module "this" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.14.0"

  create                 = var.create
  ip                     = join("", aws_eip_association.this.*.public_ip)
  user                   = "ubuntu"
  private_key_path       = pathexpand(var.private_key_path)
  verbose                = var.verbose
  become                 = true
  playbook_file_path     = "${path.module}/ansible/main.yml"
  requirements_file_path = "${path.module}/ansible/requirements.yml"
  playbook_vars          = local.playbook_vars
}
