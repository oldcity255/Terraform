data "aws_ami" "hw_3_ami" {
  executable_users = ["self"]
  most_recent      = true
  owners           = ["self"]

}