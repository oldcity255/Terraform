resource "aws_launch_configuration" "bjk" {
  # Launch Configurations cannot be updated after creation with the AWS API.
  # In order to update a Launch Configuration, Terraform will destroy the
  # existing resource and create a replacement.
  #
  # We're only setting the name_prefix here,
  # Terraform will add a random string at the end to keep it unique.
  name_prefix = "bjk-"



  image_id                    = "ami-0bda785b0bac126e4"
  instance_type               = var.instance_type
  security_groups             = var.aws_security_group_sg_1

  user_data = <<-EOF
#!/bin/bash
set -euo pipefail
<...>
echo "Checking that agent is running"
until $(curl --output /dev/null --silent --head --fail http://localhost:51678/v1/metadata); do
  printf '.'
  sleep 1
done
exit_code=$?
printf "\nDone\n"
              EOF

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "bjk" {
  # Force a redeployment when launch configuration changes.
  # This will reset the desired capacity if it was changed due to
  # autoscaling events.
  name = "${aws_launch_configuration.bjk.name}-asg"

  min_size             = 1
  desired_capacity     = 2
  max_size             = 5
  health_check_type    = "EC2"
  launch_configuration = "aws_launch_configuration.bjk.name"
  vpc_zone_identifier  = "subnet-10e0ac1e"

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}