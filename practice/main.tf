provider "aws" {
  # version = "~> 3.0"
  region  = "us-west-1"
}



resource "aws_vpc" "practice_vpc" {
  cidr_block = var.vpc_cider_block
  tags = {
    Name = "dev"
  }

}
resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("~/.ssh/id_rsa.pub")

}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.practice_vpc.id

  tags = {
    Name = "practice_ig"
  }

}
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.practice_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "prod"
  }
}


resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.practice_vpc.id
  cidr_block = var.aws_subnet_1_cider_block                        
  availability_zone = "us-west-1a"
  
  tags = {
    Name = "prod_subnet"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.dev_route_table.id
}


resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.practice_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.subnet_1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]

  # attachment {
  #   instance     = aws_instance.web.id
  #   device_index = 0
  # }
}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web_server_nic.id
  associate_with_private_ip = var.elastic_ip  
  depends_on                = [aws_internet_gateway.gw]
}

resource "aws_instance" "web" {
  ami                = var.instance_ami           
  instance_type      = "t2.micro"
  availability_zone  = "us-west-1a"
  key_name           = "my_key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web_server_nic.id
  }

  tags = {
    Name = "Terraform_1_st_hw"
  }
}

output "server_public_ip" {
  value = aws_instance.web.public_ip
}

output "server_id" {
  value = aws_instance.web.id
}
