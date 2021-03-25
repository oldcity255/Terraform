terraform {
  backend "s3" {
    bucket = "vepas-terraform-state-file"
    key    = "tfstate/homework-four.tfstate"
    region = "us-east-1"
  }
}