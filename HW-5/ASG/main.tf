provider "aws" {
  region = var.region
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = var.module_name                    

  # Launch configuration
  lc_name = var.lc_name                   

  image_id        = var.ami                  
  instance_type   = var.instance_type         
  security_groups = var.security_groups        

  ebs_block_device = [
    {
      device_name           =  "/dev/xvdz"      ############################
      volume_type           =  "gp2"
      volume_size           =  "50"
      delete_on_termination =  true
    },
  ]

  root_block_device = [
    {
      volume_size =  "50"
      volume_type =  "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = var.asg_name                         
  vpc_zone_identifier       = var.vpc_zone_identifier      
  health_check_type         = var.health_check_type          
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}