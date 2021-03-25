terraform {
  backend "s3" {
    bucket = "vepas-terraform-state-file"
    key    = "tfstate/data-source.tfstate"
    region = "us-east-1"
  }
}