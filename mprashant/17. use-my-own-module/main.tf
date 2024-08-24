provider "aws" {
  region = "us-east-1"
}

module "shubham-vpc" {
  source  = "shubhamPassi/shubham-vpc/aws"
  version = "1.0.0"
  
  # insert the 2 required variables here

  vpc_config = {
    cidr_block_vpc = "10.0.0.0/16"
    name = "shubham-vpc"
  }

  subnet_config = {  
    shubham-subnet-public-1 = {
      cidr_block_subnet = "10.0.1.0/24"
      az = "us-east-1a"
      # To set the subnet as public, default is private
      public = true
    }

    shubham-subnet-private = {
      cidr_block_subnet = "10.0.0.0/24"
      az = "us-east-1b"
    }
  }

}