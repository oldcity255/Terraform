data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

resource "aws_instance" "web" {

  ami             = var.ami[var.region] 
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  subnet_id       = data.aws_subnet.existing_subnet.id
  key_name        = lower(var.key_name)


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







 
 


