terraform {
  backend "s3" {
    bucket = "vepas-terraform-state-file"
    key    = "tfstate/webserver.tfstate"
    region = "us-east-1"
  }
}