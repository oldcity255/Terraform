resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.Vepa_Vpc.id

  route {
    cidr_block = var.route_table_cidr  
    gateway_id = aws_internet_gateway.Humay_ig.id
  }


  tags = {
    Name = "${var.prefix}route_table"
  }
}