
variable region {}


#variables of ec2
variable key_name {}
variable ssh_key_path {}
variable cidr_block_private_subnet1 {}
variable cidr_block_private_subnet2 {}
variable "rds_port" {}
variable security_group_db {}
variable ami {}
variable instance_type {}

#variable "subnet_id" {}

variable prefix {}
#variable "vpc_id" {}
variable security_group_ec2 {}
variable cidr_block_public_subnet {}

#variables of rds
variable subnetgroup {}
variable allocated_storage {}
variable engine {}           
variable engine_version {}        
variable instance_class {}      
variable multi_az {}             
variable name {}             
variable username {}  
variable password {}                
variable port {}                
variable publicly_accessible {}
variable storage_encrypted {}  
variable storage_type {} 


#variables of vpc
variable cidr_block_vpc {}
variable instance_tenancy {}

variable cidr_block_route {}




       
# password              = random_password.password.result


