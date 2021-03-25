resource "aws_vpc" "Vepa_Vpc" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = var.instance_tenancy

  
  tags = {
    Name = "${var.prefix}Humay_Vpc"
    Department = "Production"
    Created_by = "Vepa"
  }
}