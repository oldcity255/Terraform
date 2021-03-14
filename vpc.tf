resource "aws_vpc" "Vepa_Vpc" {
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Humay_Vpc"
    Department = "Production"
    Created_by = "Vepa"
  }
}