terraform {
  backend "s3" {
    bucket  = "medcloud-backend-pipeline"
    key     = "terraform.tfstate"
    region  = "us-east-1"
  }
}