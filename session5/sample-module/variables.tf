#variables of vpc
variable "cidr_block_vpc" {}
variable "prefix" {}
variable "cidr_block_subnet" {}
variable "cidr_block_route" {}

#variables of web-server
variable "key_name" {}
variable "ssh_key_path" {}
variable "security_group_name" {}
# variable "vpc_id" {}
variable "ami" {}
variable "instance_type" {}
# variable "subnet_id" {}
# variable "prefix" {}
variable "region" {}