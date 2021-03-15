variable cidr_block {
    type = string
    default = "10.1.0.0/16"
    description = "Cidr block for vpc"

}

variable instance_tenancy {
    type = string
    default = "default"
    description = "A tenancy option for instances launched into the VPC"
    
}

variable key_name {
    type = string
    default = "my_key"
    description = "name of keypair"
    
}


