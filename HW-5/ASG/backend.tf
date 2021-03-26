terraform {
  backend "s3" {
    bucket = "vepas-terraform-state-file"
    key    = "tfstate/asg-module.tfstate"
    region = "us-east-1"
  }
}