output "endpoint" {
    value = module.myapp-rds.endpoint
    }

output "ip_address" {
    value = module.myapp-ec2.ip_address
}