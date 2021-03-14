resource "aws_internet_gateway" "Humay_ig" {
  vpc_id = aws_vpc.Vepa_Vpc.id

  tags = {
    Name = "Humay_ig"
    Department = "Production"
    Created_by = "Vepa"
  }
}