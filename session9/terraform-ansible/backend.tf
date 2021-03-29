terraform {
  backend "s3" {
    bucket = "vepas-terraform-state-file"
    key    = "tfstate/session-9.tfstate"
    region = "us-east-1"
  }
}