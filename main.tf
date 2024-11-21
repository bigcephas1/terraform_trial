# Define the AWS provider
provider "aws" {
  region = "us-east-1"
}

locals {
  prefix = terraform.workspace
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  cidr   = var.cidr
  prefix = local.prefix
}

# Subnet Module
module "subnet" {
  source            = "./modules/subnets"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  prefix            = local.prefix

}

# Security Group Module
module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

}

# EC2 Instance Module
module "instance" {
  source            = "./modules/instances"
  ami               = "ami-0261755bbcb8c4a84"
  instance_type     = "t2.micro"
  key_name          = module.vpc.key_name
  security_group_id = module.security_group.security_group_id
  subnet_id         = module.subnet.subnet_id
  prefix            = local.prefix
}