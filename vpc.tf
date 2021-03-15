resource "aws_vpc" "Vepa_Vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  
  tags = {
    Name = "Humay_Vpc"
    Department = "Production"
    Created_by = "Vepa"
  }
}