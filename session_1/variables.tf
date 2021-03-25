variable cidr_block_vpc {
    type = string
    
    description = "Cidr block for vpc"

}

variable instance_tenancy {
    type = string
    
    description = "A tenancy option for instances launched into the VPC"
    
}

variable key_name {
    type = string
    default = "vepa_key"
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


variable public_subnet_cidr {
    type = string
   
    description = "public subnet cidr block"
    
}

variable map_public_ip_on_launch {
    type = bool
    
    description = " Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address."
    
}


variable route_table_cidr {
    type = string
    
    description = " The CIDR block of the route."
    
}

variable security_group_name {
    type = string
    
    description = " security group name"
    
}

variable sg_description {
    type = string
   
    description = " security group description"
    
}


# variable ami {
#     type = string
#     description = "The id of the machine image (AMI) to use for the server."
#     validation {
#                  condition = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
#                  error_message = "The ami value must be a valid AMI id, starting with \"ami-\"."
#                 }
# }


variable instance_type {
    type = string
    
}

variable prefix {
    type = string
    
}