data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

# locals {
# key_name_lower = lower (var.key_name)

# }


resource "aws_instance" "web" {
  # count           = 4
  ami             = var.ami[var.region] 
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  subnet_id       = data.aws_subnet.existing_subnet.id
  key_name        = lower(var.key_name)


  # key_name        = local.key_name_lower

  # user_data = <<-EOF
  #                #!/bin/bash
  #                 sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
  #                 sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
  #                 sudo yum upgrade
  #                 sudo yum install jenkins java-1.8.0-openjdk-devel -y
  #                 sudo systemctl daemon-reload
  #                 sudo systemctl start jenkins
  #                 sudo systemctl enable jenkins
  #             EOF

   root_block_device {
    volume_size           = 16
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Name = "Root Volume-"
    }
   }

  tags = {
    Name = "${var.prefix}vepa_ec2"
    }
}

# resource "aws_ebs_volume" "extra_ebs_volume" {

#   availability_zone = "us-east-1e"
#   size              = 20
#   type              = "gp2"

#   tags = {
#     Name = "extra ebs volume"
#   }

# }

# resource "aws_volume_attachment" "ebs_attachment" {
#   device_name = "/dev/sdh" #"/dev/xvdh"
#   volume_id   = aws_ebs_volume.extra_ebs_volume.id
#   instance_id = aws_instance.web.id
# }
# connection {
#       type        = "ssh"
#       host        = self.public_ip
#       user        = "ec2-user"
#       private_key = file("~/.ssh/id_rsa")
#       # Default timeout is 5 minutes
#       timeout     = "4m"
#     }



    # provisioner "file" {
    #   content     = "Hello there"
    #   destination = "/home/ec2-user/devops.txt"
    # }

    # provisioner "file" {
    #   source      = "./instance-ip.txt"
    #   destination = "/home/ec2-user/instance-ip.txt"
    # }

  #   provisioner "local-exec" {
  #     command = "echo ${self.public_ip} > instance-ip1.txt"
  #   }

  # provisioner "remote-exec" {
  #     inline = [
  #       "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo",
  #       "sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
  #       "sudo yum upgrade",
  #       "sudo yum install jenkins java-1.8.0-openjdk-devel -y",
  #       "sudo systemctl daemon-reload",
  #       "sudo systemctl start jenkins",
  #       "sudo systemctl enable jenkins"
  #     ]
  #   }

#   provisioner "remote-exec" {
#         inline = [
#           "touch /home/ec2-user/devops-remote-exec.txt",
#           "sudo yum install httpd -y",
#           "sudo systemctl enable httpd",
#           "sudo systemctl start httpd"
#         ]
#       }


