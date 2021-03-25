provider "aws" {
  region = var.region
}

module "myapp-vpc" {
    # source = "./vpc"
    source = "github.com/sprintqaDevOps/vpc.git"
 cidr_block_vpc         = var.cidr_block_vpc
 prefix                 = var.prefix
 cidr_block_subnet      = var.cidr_block_subnet
 cidr_block_route       = var.cidr_block_route
}

module "myapp-webserver" {
    # source = "./web-server"
    source = "github.com/sprintqaDevOps/web-server.git"
 key_name               = var.key_name
 ssh_key_path           = var.ssh_key_path
 security_group_name    = var.security_group_name
 vpc_id                 = module.myapp-vpc.my_vpc.id
 ami                    = var.ami
 instance_type          = var.instance_type
 subnet_id              = module.myapp-vpc.subnet.id
 prefix                 = var.prefix
}