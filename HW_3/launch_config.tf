resource "aws_launch_configuration" "launch_conf" {
  name          = "web_config"
  image_id      = data.aws_ami.hw_3_ami.id
  instance_type = "t2.micro"
}
