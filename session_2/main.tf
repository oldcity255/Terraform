terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

variable "vpc_id" {}

data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

variable "subnet_id" {}

data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

data "aws_ami" "latest_amazon_linux_image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami             = var.ami 
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  subnet_id       = data.aws_subnet.existing_subnet.id
  key_name        = "my_key"

  tags = {
    Name = "${var.prefix}vepa_ec2"
  }



  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      # Default timeout is 5 minutes
      timeout     = "4m"
    }

    provisioner "file" {
      content     = "Hello there"
      destination = "/home/ec2-user/devops.txt"
    }

    provisioner "file" {
      source      = "./instance-ip.txt"
      destination = "/home/ec2-user/instance-ip.txt"
    }

    provisioner "local-exec" {
      command = "echo ${self.public_ip} > instance-ip.txt"
    }

    # provisioner "remote-exec" {
    # 	inline = [
    # 		"touch /home/ec2-user/devops-remote-exec.txt",
    #     "sudo yum install httpd -y",
    #     "sudo systemctl enable httpd",
    #     "sudo systemctl start httpd"
    # 	]
    # }

}



resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = file(var.ssh_key_path)   

}

resource "aws_security_group" "sg_1" {
  name        = var.security_group_name
  description = var.sg_description 
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description = "ssh from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
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
    Name = "${var.prefix}allow_ssh_http"
  }
}

output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}

output "arn" {
  value = aws_instance.web.arn
}

variable instance_tenancy {
    type = string
    
    description = "A tenancy option for instances launched into the VPC"
    
}

variable key_name {
    type = string
    
    description = "name of keypair"
    
}

variable ssh_key_path {
    type = string
    
    description = "path of ssh public key"
    
}


variable aws_region {
    type = string
    
    description = "location of the resources"
    
}


variable security_group_name {
    type = string
    
    description = " security group name"
    
}

variable sg_description {
    type = string
   
    description = " security group description"
    
}

variable ami {
    type = string
    description = "The id of the machine image (AMI) to use for the server."
    validation {
                 condition = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
                 error_message = "The ami value must be a valid AMI id, starting with \"ami-\"."
                }
}

variable instance_type {
    type = string
    
}

variable prefix {
    type = string
  
}