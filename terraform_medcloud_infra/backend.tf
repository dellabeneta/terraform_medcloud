terraform {
  backend "s3" {
    bucket = "medcloud-backend-infra"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}