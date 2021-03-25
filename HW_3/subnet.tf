resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.Vepa_Vpc.id
  cidr_block = var.public_subnet_cidr                       
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.prefix}public_subnet_1"
  }
}