resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.Vepa_Vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Humay_ig.id
  }


  tags = {
    Name = "route_table"
  }
}