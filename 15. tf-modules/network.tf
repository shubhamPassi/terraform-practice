provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "availability_zone" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.availability_zone.names
  private_subnets = [ "10.0.1.0/24", "10.0.2.0/24"  ]
  public_subnets  = [ "10.0.3.0/24", "10.0.4.0/24"  ]

  tags = {
    Name = "shubham-vpc"  
  }
}