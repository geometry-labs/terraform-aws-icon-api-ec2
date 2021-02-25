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

locals {
  playbook_vars = merge({
    network_name           = var.network_name,
    instance_type          = var.instance_type,
    instance_store_enabled = local.instance_store_enabled,
    this_instance_id       = join("", aws_instance.this.*.id),
    dhcp_ip                = join("", aws_instance.this.*.public_ip),
  }, var.playbook_vars)
}

module "this" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.14.0"

  create             = var.create
  ip                 = join("", aws_eip_association.this.*.public_ip)
  user               = "ubuntu"
  private_key_path   = pathexpand(var.private_key_path)
  verbose            = var.verbose
  become             = true
  playbook_file_path = "${path.module}/ansible/main.yml"
  playbook_vars = merge({
    ssl_enable = domain_name != ""
  }, local.playbook_vars)
  requirements_file_path = "${path.module}/ansible/requirements.yml"
}
