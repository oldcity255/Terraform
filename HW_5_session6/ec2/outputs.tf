output vpc_sg_ids {
    value = aws_security_group.ec2
    }

    output "ip_address" {
    value = aws_instance.web.public_ip
}