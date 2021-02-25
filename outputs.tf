
output "instance_store_enabled" {
  value = local.instance_store_enabled
}

output "public_ip" {
  value = join("", aws_eip_association.this.*.public_ip)
}

output "instance_type" {
  value = var.instance_type
}

output "network_name" {
  value = var.network_name
}

output "instance_id" {
  value = join("", aws_instance.this.*.id)
}

//output "ebs_volume_arn" {
//  value = join("", aws_ebs_volume.this.*.arn)
//}

output "key_name" {
  value = join("", aws_key_pair.this.*.key_name)
}
