terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "myapp-ec2" {
    source = "./ec2"
    key_name                    = var.key_name
    ssh_key_path                = var.ssh_key_path
    cidr_block_private_subnet1  = var.cidr_block_private_subnet1
    cidr_block_private_subnet2  = var.cidr_block_private_subnet2
    rds_port                    = var.rds_port
    security_group_db           = var. security_group_db
    ami                         = var.ami
    instance_type               = var.instance_type

    subnet_id                   = module.myapp-vpc.subnet.id

    prefix                      = var.prefix
    vpc_id                      = module.myapp-vpc.my_vpc.id
    security_group_ec2          = var.security_group_ec2
    cidr_block_public_subnet    = var.cidr_block_public_subnet
}

module "myapp-vpc" {
    source = "./vpc"
    cidr_block_vpc           = var.cidr_block_vpc   
    instance_tenancy         = var.instance_tenancy
    cidr_block_public_subnet = var.cidr_block_public_subnet
    cidr_block_route         = var.cidr_block_route
    prefix                   = var.prefix
}

module "myapp-rds" {
 source                      = "./rds"
 subnetgroup                 = var.subnetgroup
 allocated_storage           = var.allocated_storage
 engine                      = var.engine
 engine_version              = var.engine_version
 instance_class              = var.instance_class
 multi_az                    = var.multi_az
 name                        = var.name
 username                    = var.username
 password                    = var.password   
 port                        = var.port   
 publicly_accessible         = var.publicly_accessible
 storage_encrypted           = var.storage_encrypted
 storage_type                = var.storage_type
 cidr_block_private_subnet1  = var.cidr_block_private_subnet1
 cidr_block_private_subnet2  = var.cidr_block_private_subnet2
 vpc_security_group_ids      = module.myapp-ec2.vpc_sg_ids.id
 vpc_id                      = module.myapp-vpc.my_vpc.id
 prefix                      = var.prefix
}




#vpc_id = ????
#vpc_security_group_ids = ???