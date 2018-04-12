# Store terraform state in S3
terraform {
  required_version = ">= 0.11"
  backend "s3" {
    bucket = "jjamor-terraform-states"
    key = "learningtf/vpc-example"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
}

data "aws_availability_zones" "azs" {
}

resource "aws_vpc" "tfvpctest" {
 cidr_block = "172.32.0.0/16"
 tags {
   Name = "tfvpctest"
 }
}

resource "aws_subnet" "tfsubnet1" {
 vpc_id = "${aws_vpc.tfvpctest.id}"
 cidr_block = "172.32.0.0/24"
 availability_zone = "${data.aws_availability_zones.azs.names[0]}"
 tags {
   Name = "tfsubnet1"
 }
}

resource "aws_subnet" "tfsubnet2" {
 vpc_id = "${aws_vpc.tfvpctest.id}"
 cidr_block = "172.32.1.0/24"
 availability_zone = "${data.aws_availability_zones.azs.names[1]}"
 tags {
   Name = "tfsubnet2"
 }
}

resource "aws_subnet" "tfsubnet3" {
 vpc_id = "${aws_vpc.tfvpctest.id}"
 cidr_block = "172.32.2.0/24"
 availability_zone = "${data.aws_availability_zones.azs.names[2]}"
 tags {
   Name = "tfsubnet3"
 }
}

resource "aws_internet_gateway" "tfgw" {
  vpc_id = "${aws_vpc.tfvpctest.id}"

  tags {
    Name = "tfgw"
  }
}

#output "outputazs" {
#  value = "${data.aws_availability_zones.azs.names}"
#}

