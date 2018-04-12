# Create S3 bucket for Terraform states
terraform {
  required_version = ">= 0.11"
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "jjamor-terraform-states" {
  bucket = "jjamor-terraform-states"
  provider = "aws" # Create in us-east-1
  acl = "private"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}


