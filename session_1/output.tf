output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}

output "aws_security_group" {
  value = aws_security_group.sg_1.owner_id 
}
