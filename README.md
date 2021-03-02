<p align="center">
  <h3 align="center">terraform-icon-aws-api-ec2</h3>

  <p align="center">
    Terraform module to setup a node to run the streaming data stack for the ICON Blockchain.
    <br />
</p>

See [icon-api](https://github.com/geometry-labs/icon-api) for more information on the application stack. 

## Terraform Versions

For Terraform v0.12.0+

## Usage

```hcl
module "this" {
  source = "github.com/geometry-labs/terraform-icon-aws-api"
  name                = random_pet.this.id
  availability_zone   = "${var.aws_region}a"
  subnet_id           = module.vpc.public_subnets[0]
  vpc_id              = module.vpc.vpc_id
  private_key_path    = var.private_key_path
  public_key_path     = var.public_key_path
  domain_name         = "geometry-ci.net"
  certbot_admin_email = "foo@bar.com"

// Optional values.  See table below for more options. 
//  instance_type = "m5.xlarge" # spendy but you'll appreciate it if running intensive queries
//  root_volume_size = 400 # If you aren't interested in historical, set to smaller as it will fill up as time goes.  400 is for from genesis
}
```
## Examples

- [defaults](https://github.com/geometry-labs/terraform-icon-aws-api/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_security\_group\_ids | List of security groups | `list(string)` | `[]` | no |
| availability\_zone | n/a | `string` | n/a | yes |
| certbot\_admin\_email | n/a | `string` | `""` | no |
| create | Boolean to create resources or not | `bool` | `true` | no |
| create\_sg | Bool for create security group | `bool` | `true` | no |
| domain\_name | n/a | `string` | `""` | no |
| ebs\_size | n/a | `number` | `400` | no |
| hostname | n/a | `string` | `""` | no |
| iam\_instance\_profile\_id | Instance profile ID | `string` | n/a | yes |
| instance\_type | Instance type | `string` | `"t3.small"` | no |
| key\_name | The key pair to import - leave blank to generate new keypair from pub/priv ssh key path | `string` | `""` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| name | The name for the label | `string` | `"icon-api"` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `"mainnet"` | no |
| playbook\_vars | Additional playbook vars | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| private\_port\_cidrs | List of CIDR blocks for private ports | `list(string)` | <pre>[<br>  "172.31.0.0/16"<br>]</pre> | no |
| private\_ports | List of publicly open ports | `list(number)` | <pre>[<br>  9100,<br>  9113,<br>  9115,<br>  8080<br>]</pre> | no |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| public\_ports | List of publicly open ports | `list(number)` | <pre>[<br>  22,<br>  80,<br>  443<br>]</pre> | no |
| root\_iops | n/a | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `number` | `20` | no |
| root\_volume\_type | n/a | `string` | `"gp2"` | no |
| subnet\_id | The id of the subnet | `string` | `""` | no |
| tags | Map of tags | `map(string)` | `{}` | no |
| verbose | Verbose ansible run | `bool` | `false` | no |
| vpc\_id | Custom vpc id - leave blank for deault | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| instance\_store\_enabled | n/a |
| instance\_type | n/a |
| key\_name | n/a |
| network\_name | n/a |
| public\_ip | n/a |
| security\_group\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [geometry-labs](https://github.com/geometry-labs)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.