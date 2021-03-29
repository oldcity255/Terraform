terraform {
  backend "s3" {
    bucket = "vepas-terraform-state-file"
    key    = "tfstate/session6.tfstate"
    region = "us-east-1"
  }
}