provider "aws" {
  region = var.region
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# locals {

#     setup_name = "bjk"
# }



# # resource "aws_vpc" "practice_vpc" {
# #   cidr_block = var.vpc_cidr_block
# # tags = {
# #     Name = "${local.setup_name}-vpc"
# #   }

# # }

# data "aws_vpc" "practice" {
#  filter {
#      name = "tag:Name"
#      values= ["bjk-vpc"]
#  }

# }

# output "vpc_of_default_vpc" {

#     value = data.aws_vpc.practice
# }



# resource "aws_subnet" "public_subnet" {
#   vpc_id     = data.aws_vpc.practice.id
#   cidr_block = var.public_subnet_cidr_block

#   tags = {
#     Name = "${local.setup_name}-HelloWorld"
#  }
# }

resource "aws_instance" "practice_instance" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.public_subnet.id

  tags = {
    Name = "${local.setup_name}-champion"
  }
}



