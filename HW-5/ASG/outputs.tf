output "asg_group_id" {
    value = module.asg.this_autoscaling_group_id 
}

output "lf_id" {
    value = module.asg.this_launch_configuration_id
}