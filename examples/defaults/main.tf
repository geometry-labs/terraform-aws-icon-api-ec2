variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

variable "private_key_path" {}
variable "public_key_path" {}

resource "random_pet" "this" {
  length = 2
}

module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  name           = random_pet.this.id
  cidr           = "192.168.0.0/24"
  azs            = ["${var.aws_region}a"]
  public_subnets = ["192.168.0.0/24"]
  enable_ipv6    = true
}

module "main" {
  source            = "../.."
  name              = random_pet.this.id
  availability_zone = "${var.aws_region}a"
  private_key_path  = var.private_key_path
  public_key_path   = var.public_key_path
  subnet_id         = module.vpc.public_subnets[0]
  vpc_id            = module.vpc.vpc_id
}
