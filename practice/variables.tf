variable "public_subnet_cidr_block" {
    type = string
    # default="10.0.1.0/24"
    description = "The CIDR block for the subnet."
}

variable "vpc_cidr_block" {
    type = string
    # default="10.0.0.0/16"
    description = "The CIDR block for the VPC."
}


# variable "instance_tags" {
#     type = object ({
#         name = string
#         foo = number
#     })
    
#     description = "The CIDR block for the VPC."
# }